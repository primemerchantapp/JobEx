import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/category_provider.dart';

class CategoryDropdown extends StatefulWidget {
  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Optionally, fetch categories here or in the parent widget
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    // Wait until categories are fetched
    if (categoryProvider.categories.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final categoryTitles =
        categoryProvider.categories.map((cat) => cat.title).toList();

    return DropdownButton<String>(
      value: _selectedCategory,
      hint: Text('Select a category'),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      items: categoryTitles.map<DropdownMenuItem<String>>((title) {
        return DropdownMenuItem<String>(
          value: title,
          child: Text(title),
        );
      }).toList(),
    );
  }
}
