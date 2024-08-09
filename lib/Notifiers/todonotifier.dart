import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickpad/Models/todomodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoNotifier extends StateNotifier<List<Todomodel>> {
  TodoNotifier() : super([]);
  Future<void> loadTodo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todoJson = await prefs.getStringList('todo')?? [];
    final todoList = todoJson.map((td)=> Todomodel.fromJson(jsonDecode(td))).toList();
  }
  Future<void> addTodo(Todomodel todo) async {
    state = [...state, todo];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todoJson = state.map((todo)=> jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todo', todoJson);
  }

  Future<void> removeTodo(Todomodel todo) async {
    state = state.where((item) => item != todo).toList();
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todomodel>>((ref) {
  return TodoNotifier();
});
