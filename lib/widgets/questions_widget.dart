/// Provides the [QuestionsWidget] class.
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

import '../json/answer.dart';
import '../json/category.dart';
import '../json/question.dart';
import '../json/question_list.dart';
import '../open_trivia_db.dart';

class QuestionsWidget extends StatefulWidget {
  @override
  QuestionsWidget(this._factory, this._category) : super();

  final QuestionFactory _factory;
  final Category _category;

  @override
  QuestionsWidgetState createState() =>
      QuestionsWidgetState(_factory, _category);
}

class QuestionsWidgetState extends State<QuestionsWidget> {
  @override
  QuestionsWidgetState(this._factory, this._category) : super();

  final QuestionFactory _factory;
  final Category _category;
  List<Question> _questions;

  int _correct = 0;
  int _total = 0;

  AudioCache _audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_questions == null) {
      child = const Text('Loading...');
      loadQuestions();
    } else if (_questions.isEmpty) {
      child = ListView(
        children: <Widget>[
          const Text('You have exhausted all the questions.'),
          Text('Questions asked: $_total'),
          Text('Number of correct answers: $_correct'),
          Text('Number of incorrect answers: ${_total - _correct}'),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'More Questions',
            onPressed: () => setState(() {
              _questions = null;
              loadQuestions();
            }),
          )
        ],
      );
    } else {
      final Question q = _questions.removeLast();
      String difficulty = q.difficulty.toString();
      difficulty = difficulty.substring(difficulty.indexOf('.'));
      difficulty = difficulty[0].toUpperCase() + difficulty.substring(1);
      final List<ListTile> tiles = <ListTile>[
        ListTile(
          title: Text('${q.category} ($difficulty)'),
          subtitle: Semantics(
            child: Text(q.getText()),
            liveRegion: true,
          ),
        )
      ];
      for (final Answer answer in q.answers) {
        tiles.add(ListTile(
          title: Text(answer.text),
          onTap: () => setState(() {
            if (answer.isCorrect) {
              _correct++;
              playCorrect();
            } else {
              playIncorrect();
            }
            _total++;
          }),
        ));
      }
      child = ListView(children: tiles);
    }
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(),
          title: Text('Question ($_correct correct, $_total total)')),
      body: child,
    );
  }

  Future<void> loadQuestions() async {
    final QuestionList ql = await _factory.getQuestions(category: _category);
    await _audioCache
        .loadAll(<String>['sounds/correct.wav', 'sounds/incorrect.wav']);
    print(_audioCache.loadedFiles);
    setState(() {
      _questions = ql.questions;
    });
  }

  Future<void> playCorrect() async {
    await _audioCache.play('sounds/correct.wav');
  }

  Future<void> playIncorrect() async {
    await _audioCache.play('sounds/incorrect.wav');
  }
}
