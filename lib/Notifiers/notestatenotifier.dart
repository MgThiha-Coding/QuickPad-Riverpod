import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:quickpad/Models/model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NoteNotifier extends Notifier<List<Note>> {
  NoteNotifier() : super() {
    loadNote();
  }

  @override
  List<Note> build() {
    return [];
  }

  Future<void> loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final noteJsonList = prefs.getStringList('notes') ?? [];
    final notes = noteJsonList
        .map((jsonString) => Note.fromJson(jsonDecode(jsonString)))
        .toList();
    state = notes;
  }

  Future<void> saveNote(Note note) async {
    state = [...state, note];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final noteJsonList =
        state.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', noteJsonList);
  }

  Future<void> deleteNote(Note note) async {
    state = state.where((n) => n != note).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final noteJsonList =
        state.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', noteJsonList);
  }

  Future<void> updateNote(Note oldNote, Note newNote) async {
    List<Note> updatedNotes = List.from(state);
    for (int i = 0; i < updatedNotes.length; i++) {
      if (updatedNotes[i] == oldNote) {
        updatedNotes[i] = newNote;
        break;
      }
    }
    state = updatedNotes;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final noteJsonList =
        state.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes', noteJsonList);
  }
}

final noteStateProvider = NotifierProvider<NoteNotifier, List<Note>>(() {
  return NoteNotifier();
});
