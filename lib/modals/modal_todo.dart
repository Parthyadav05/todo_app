import 'package:flutter/material.dart';
class Todo{
  String content;
  int  todoId;
  bool Completed;
  Todo({
    required this.content,
    required this.todoId,
    required this.Completed
  });
}