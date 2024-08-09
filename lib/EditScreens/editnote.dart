import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickpad/Models/model.dart';
import 'package:quickpad/Notifiers/notestatenotifier.dart';


class EditNote extends ConsumerStatefulWidget {
  const EditNote({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  ConsumerState<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends ConsumerState<EditNote> {
  late TextEditingController _titleController;
  late TextEditingController _storyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _storyController = TextEditingController(text: widget.note.story);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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
                    widget.note.date,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final title = _titleController.text;
                    final story = _storyController.text;
                    final updatedNote = Note(
                      title: title,
                      story: story,
                      date: widget.note.date,
                    );
                    ref.read(noteStateProvider.notifier).updateNote(widget.note, updatedNote);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Note updated",
                        style: TextStyle(color: Colors.blue),
                      ),
                      backgroundColor: Colors.white,
                      duration: Duration(seconds: 1),
                    ));
                    Navigator.of(context).pop(); // Navigate back to NoteList
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
