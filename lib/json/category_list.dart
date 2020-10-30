/// Provides the [CategoryList] class.
import 'package:json_annotation/json_annotation.dart';

import 'category.dart';

part 'category_list.g.dart';

@JsonSerializable()
class CategoryList {
  // ignore: non_constant_identifier_names
  CategoryList({this.trivia_categories}) {
    for (final Map<String, dynamic> data in trivia_categories) {
      categories.add(Category.fromJson(data));
    }
  }

  final List<Category> categories = <Category>[];
  // ignore: non_constant_identifier_names
  final List<Map<String, dynamic>> trivia_categories;

  factory CategoryList.fromJson(Map<String, dynamic> json) =>
      _$CategoryListFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryListToJson(this);
}
