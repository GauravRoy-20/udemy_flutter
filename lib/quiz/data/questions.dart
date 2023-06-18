import 'package:udemy_flutter/quiz/models/quiz_question.dart';

const questions = [
  QuizQuestion(
    "What is Flutter?",
    [
      "Flutter is an open-source UI toolkit",
      "Flutter is an open-source backend development framework",
      "Flutter is an open-source programming language for cross-platform applications",
      "Flutters is a DBMS toolkit"
    ],
  ),
  QuizQuestion(
    "Who developed the Flutter Framework and continues to maintain it today?",
    ["Google", "Facebook", "Microsoft", "Oracle"],
  ),
  QuizQuestion(
    "Which programming language is used to build Flutter applications?",
    ["Dart", "Kotlin", "Java", "Go"],
  ),
  QuizQuestion(
    "How many types of widgets are there in Flutter?",
    ["2", "4", "6", "8"],
  ),
  QuizQuestion(
    "When building for iOS, Flutter is restricted to an __ compilation strategy",
    [
      "AOT (ahead-of-time)",
      "JIT (Just-in-time)",
      "Transcompilation",
      "Recompilation"
    ],
  ),
  QuizQuestion(
    "A sequence of asynchronous Flutter events is known as a:",
    ["Stream", "Flow", "Current", "Series"],
  ),
];
