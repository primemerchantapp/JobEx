import 'package:flutter/material.dart';
import 'package:jobizz/widgets/CategoryGridItem.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';

class CategoriesGridCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the number of columns based on the screen width
    final crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return FutureBuilder(
      future: Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: categoryProvider.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final category = categoryProvider.categories[index];
                  return CategoryGridItem(category: category);
                },
              );
            },
          );
        }
      },
    );
  }
}
