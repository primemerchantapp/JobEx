import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../components/CustomRichText.dart';
import '../../components/CustomTextField.dart';
import '../../components/button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/jobapplication_provider.dart';
import '../../theme/app_theme.dart';
import '../../theme/color.dart';
import '../../widgets/AppBarWidget.dart';

class JobApplicationScreen extends StatefulWidget {
  const JobApplicationScreen({Key? key}) : super(key: key);
  static const routeName = '/job-application';

  @override
  State<JobApplicationScreen> createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _coverLetterController = TextEditingController();
  final TextEditingController _additionalDetailsController =
      TextEditingController();
  String _resumePath = '';
  bool _isUploading = false;

  // Function to upload resume to Firebase Storage
  Future<String?> _uploadResume(String path) async {
    try {
      final File file = File(path);
      final String fileName = path.split('/').last;
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('resume/$fileName');
      final UploadTask uploadTask = storageRef.putFile(file);

      // Get the download URL after uploading
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading resume: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload resume')),
      );
      return null;
    }
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() {
        _resumePath = result.files.single.path ?? '';
      });
    }
  }

  void _applyForJob(BuildContext context, String jobId) async {
    final auth = Provider.of<Auth>(context, listen: false);

    if (_resumePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please attach your resume')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    final String? resumeUrl = await _uploadResume(_resumePath);

    setState(() {
      _isUploading = false;
    });

    if (resumeUrl != null) {
      _submitApplication(
        context,
        jobId,
        auth.userId,
        _firstNameController.text,
        _lastNameController.text,
        _phoneNumberController.text,
        resumeUrl,
      );
    }
  }

  void _submitApplication(
    BuildContext context,
    String jobId,
    String? userId,
    String firstName,
    String lastName,
    String contactNumber,
    String resumeUrl,
  ) {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to submit an application')),
      );
      return;
    }

    if (_coverLetterController.text.isEmpty || resumeUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please provide both a cover letter and a resume')),
      );
      return;
    }

    Provider.of<JobApplications>(context, listen: false).addApplication(
      jobId: jobId,
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      contactNumber: contactNumber,
      coverLetter: _coverLetterController.text,
      additionalDetails: _additionalDetailsController.text,
      resumePath: resumeUrl,
    );

    // Navigator.of(context).pushReplacementNamed(
    //   ApplicationConfirmationScreen.routeName,
    // );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final jobId = routeArgs['jobId']!;

    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        padding: AppTheme.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10),
            CustomTextField(
              label: 'First Name',
              controller: _firstNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter First Name' : null,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Last Name',
              controller: _lastNameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter Last Name' : null,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Contact Number',
              controller: _phoneNumberController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a contact number' : null,
            ),
            const SizedBox(height: 10),
            RichTextField(
              title: 'Cover Letter',
              description: 'Write your cover letter here',
              controller: _coverLetterController,
              validator: (value) =>
                  value!.isEmpty ? 'Cover Letter is required' : null,
            ),
            const SizedBox(height: 10),
            RichTextField(
              title: 'Additional Details',
              description: 'Any additional information you want to provide',
              controller: _additionalDetailsController,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isUploading ? null : _pickResume,
              icon: const Icon(Icons.attach_file, color: LightColor.background),
              label: Text('Attach Resume',
                  style: TextStyle(color: LightColor.background)),
              style: ElevatedButton.styleFrom(
                backgroundColor: LightColor.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            if (_resumePath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Resume Attached: ${_resumePath.split('/').last}',
                  style: AppTheme.subTitleStyle,
                ),
              ),
            if (_isUploading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        // child: CustomButton(
        //   label: 'SUBMIT APPLICATION',
        //   onPressed: _isUploading ? null : () => _applyForJob(context, jobId),
        // ),
      ),
    );
  }
}
