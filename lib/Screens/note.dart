import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quickpad/Models/model.dart';
import 'package:quickpad/Notifiers/notestatenotifier.dart';
import 'package:quickpad/Screens/notelist.dart';


class AddNote extends ConsumerStatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  ConsumerState<AddNote> createState() => _NoteState();
}

class _NoteState extends ConsumerState<AddNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(date);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  child: Text(
                    formattedDate,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final title = _titleController.text;
                    final story = _storyController.text;
                    if (title.isNotEmpty || story.isNotEmpty) {
                      final note = Note(
                        title: title,
                        story: story,
                        date: formattedDate,
                      );
                      ref.read(noteStateProvider.notifier).saveNote(note);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Note saved",
                          style: TextStyle(color: Colors.blue),
                        ),
                        backgroundColor: Colors.white,
                        duration: Duration(seconds: 1),
                      ));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Notelist()));
                      _titleController.clear();
                      _storyController.clear(); // Navigate back to NoteList
                    }
                  },
                  icon: Icon(Icons.save_alt_sharp),
                ),
              ],
            ),
            TextField(
              maxLines: null,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Add Title",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Divider(),
            TextField(
              maxLines: null,
              controller: _storyController,
              decoration: InputDecoration(
                hintText: "Your Story..",
                contentPadding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
