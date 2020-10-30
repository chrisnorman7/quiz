/// Provides the [CategoriesWidget] class.
import 'package:flutter/material.dart';

import '../json/category.dart';
import '../json/category_list.dart';
import '../open_trivia_db.dart';
import 'questions_widget.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  CategoriesWidgetState createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  final QuestionFactory _factory = QuestionFactory();
  List<Category> _categories;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_categories == null) {
      child = const Text('Loading...');
      loadCategories();
    } else {
      child = ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ListTile(
                title: const Text('Any'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<QuestionsWidget>(
                        builder: (BuildContext context) =>
                            QuestionsWidget(_factory, null))),
              );
            } else {
              final Category category = _categories[index];
              return ListTile(
                  title: Text(category.name),
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<QuestionsWidget>(
                            builder: (BuildContext context) =>
                                QuestionsWidget(_factory, category)),
                      ));
            }
          },
          itemCount: _categories.length + 1);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: child,
    );
  }

  Future<void> loadCategories() async {
    if (!_factory.hasToken) {
      await _factory.getToken();
      final CategoryList cl = await _factory.getCategories();
      setState(() {
        _categories = cl.categories;
      });
    }
  }
}
