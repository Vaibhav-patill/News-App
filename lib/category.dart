import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategorySelector({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton(
              category: 'general',
              title: 'General',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'business',
              title: 'Business',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'entertainment',
              title: 'Entertainment',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'health',
              title: 'Health',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'science',
              title: 'Science',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'sports',
              title: 'Sports',
              onCategorySelected: onCategorySelected),
          CategoryButton(
              category: 'technology',
              title: 'Technology',
              onCategorySelected: onCategorySelected),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;
  final String title;
  final Function(String) onCategorySelected;

  const CategoryButton(
      {required this.category,
      required this.title,
      required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onCategorySelected(category),
        child: Text(title),
      ),
    );
  }
}
