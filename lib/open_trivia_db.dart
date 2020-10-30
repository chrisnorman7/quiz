/// Provides the [QuestionFactory] class.
import 'dart:convert';

import 'package:http/http.dart';

import 'json/category.dart';
import 'json/category_list.dart';
import 'json/question_list.dart';
import 'json/token_request.dart';

const String authority = 'opentdb.com';
const String apiPart = 'api.php';
const String tokenPart = 'api_token.php';
const String categoriesPath = 'api_category.php';

class QuestionFactory {
  String _token;

  Future<void> getToken() async {
    final Uri u =
        Uri.https(authority, tokenPart, <String, String>{'command': 'request'});
    final Response r = await get(u);
    final TokenRequest req = TokenRequest.fromJson(jsonDecode(r.body));
    _token = req.token;
  }

  Future<QuestionList> getQuestions(
      {int amount = 10, Category category}) async {
    assert(_token != null, 'You must generate a token first.');
    final Map<String, String> params = <String, String>{
      'amount': amount.toString()
    };
    if (category != null) {
      params['category'] = category.id.toString();
    }
    final Uri u = Uri.https(authority, apiPart, params);
    final Response r = await get(u);
    final QuestionList questions = QuestionList.fromJson(jsonDecode(r.body));
    return questions;
  }

  Future<CategoryList> getCategories() async {
    final Uri u = Uri.https(authority, categoriesPath);
    final Response r = await get(u);
    return CategoryList.fromJson(jsonDecode(r.body));
  }

  bool get hasToken => _token != null;
}
