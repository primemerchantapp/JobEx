import 'package:flutter/material.dart';
import 'package:jobizz/theme/color.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?>? validator;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue[300]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
          ),
          filled: true,
          fillColor: Colors.blue[50],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: TextStyle(
          color: Colors.blue[900],
          fontSize: 16,
        ),
        icon: Icon(Icons.arrow_drop_down, color: LightColor.iconColor),
        isExpanded: true,
        dropdownColor: Colors.blue[50],
        items: items.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: TextStyle(color: LightColor.black),
            ),
          );
        }).toList(),
        validator: validator,
        onSaved: onSaved,
        onChanged: (value) {},
      ),
    );
  }
}
