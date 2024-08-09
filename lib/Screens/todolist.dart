import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickpad/Notifiers/todonotifier.dart';

class Todolist extends ConsumerStatefulWidget {
  const Todolist({super.key});

  @override
  ConsumerState<Todolist> createState() => _TodolistState();
}

class _TodolistState extends ConsumerState<Todolist> {
  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(todoProvider);
    return Scaffold(
       appBar: AppBar( 
         title: Text("To-Do List"),
       ),
       body: Padding(   
         padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
         child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  final td = todo[index];
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Are you sure to delete?",
                              style: TextStyle(fontSize: 19),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    ref
                                        .read(todoProvider.notifier)
                                        .removeTodo(td);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Deleted"),
                                        backgroundColor: Colors.white,
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          maxLines: null,
                          td.title,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        subtitle: Text(
                          maxLines: null,
                          td.purpose,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        trailing: Text(
                          td.date,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              ),
       ),
    );
  }
}