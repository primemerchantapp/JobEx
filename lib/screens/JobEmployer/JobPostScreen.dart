import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../components/CustomDropDown.dart';
import '../../components/CustomTextField.dart';
import '../../components/button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/jobs_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color.dart';
import '../../widgets/AppBarWidget.dart';
import '../../components/CatedoryDropdown.dart';

class JobPostScreen extends StatefulWidget {
  static const routeName = '/job-post';

  @override
  _JobPostScreenState createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title,
      _description,
      _requirements,
      _location,
      _category,
      _employerName;
  double? _salary;
  String? _rate, _imageUrl;
  bool _isUploadingImage = false;
  final List<String> _frequencyOptions = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppTheme.padding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleField(),
                SizedBox(height: 10),
                _buildDescriptionField(),
                SizedBox(height: 10),
                _buildRequirementsField(),
                SizedBox(height: 10),
                _buildLocationField(),
                SizedBox(height: 10),
                _buildPayRateField(),
                SizedBox(height: 10),
                _buildFrequencyDropdown(),
                SizedBox(height: 10),
                CategoryDropdown(),
                SizedBox(height: 10),
                _buildEmployerField(),
                SizedBox(height: 20),
                _buildImageUploadButton(),
                SizedBox(height: 30),
                CustomButton(label: 'POST JOB', onPressed: _postJob)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() => CustomTextField(
        label: 'Name Of Job',
        onSaved: (value) => _title = value,
        validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
      );

  Widget _buildDescriptionField() => CustomTextField(
        label: 'Job Description',
        onSaved: (value) => _description = value,
        validator: (value) =>
            value!.isEmpty ? 'Please enter the Job descriptions' : null,
        maxLines: 5, // Adjust max lines to avoid excessive space
      );

  Widget _buildRequirementsField() => CustomTextField(
        label: 'Job Requirements',
        onSaved: (value) => _requirements = value,
        validator: (value) =>
            value!.isEmpty ? 'Please enter Job requirements' : null,
        maxLines: 5, // Adjust max lines to avoid excessive space
      );

  Widget _buildLocationField() => CustomTextField(
        label: 'Location',
        onSaved: (value) => _location = value,
        validator: (value) =>
            value!.isEmpty ? 'Please enter Job location' : null,
      );

  Widget _buildPayRateField() => CustomTextField(
        label: 'Salary',
        onSaved: (value) => _salary = double.tryParse(value!),
        validator: (value) => value!.isEmpty || double.tryParse(value) == null
            ? 'Please enter a valid salary'
            : null,
        keyboardType: TextInputType.number,
      );

  Widget _buildFrequencyDropdown() => CustomDropdownField(
        items: _frequencyOptions,
        onSaved: (value) => _rate = value as String?,
        validator: (value) => value == null ? 'Please select a rate' : null,
        label: 'Rate',
      );

  Widget _buildEmployerField() => CustomTextField(
        label: "Employer Name",
        onSaved: (value) => _employerName = value,
        validator: (value) =>
            value!.isEmpty ? 'Please enter an employer name or company' : null,
      );

  Widget _buildImageUploadButton() {
    return Column(
      children: [
        if (_isUploadingImage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ElevatedButton(
          onPressed: _pickAndUploadImage,
          child: Text('Upload Job cover Image', style: AppTheme.h6Style),
          style: ElevatedButton.styleFrom(
            backgroundColor: LightColor.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickAndUploadImage() async {
    setState(() => _isUploadingImage = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.bytes != null) {
          String fileName = file.name;
          UploadTask uploadTask = FirebaseStorage.instance
              .ref('jobImages/$fileName')
              .putData(file.bytes!);

          TaskSnapshot snapshot = await uploadTask;
          _imageUrl = await snapshot.ref.getDownloadURL();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Job cover image successfully updated!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print('Image upload failed: $e');
    } finally {
      setState(() => _isUploadingImage = false);
    }
  }

  void _postJob() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final jobProvider = Provider.of<Jobs>(context, listen: false);
    final authProvider = Provider.of<Auth>(context, listen: false);

    final job = Job(
      id: '',
      title: _title!,
      description: _description!,
      requirements: _requirements!,
      location: _location!,
      salary: _salary!,
      rate: _rate!,
      category: _category!,
      employerName: _employerName!,
      employerId: authProvider.userId!,
      imageUrl: _imageUrl!,
      timestamp: DateTime.now(),
    );

    await jobProvider.addJob(job);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Job Posted Successfully!', style: AppTheme.h6Style),
      ),
    );
    Navigator.of(context).pop();
  }
}
