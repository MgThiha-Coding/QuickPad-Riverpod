import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickpad/EditScreens/editnote.dart';
import 'package:quickpad/Notifiers/notestatenotifier.dart';


class Notelist extends ConsumerStatefulWidget {
  const Notelist({super.key});

  @override
  ConsumerState<Notelist> createState() => _NotelistState();
}

class _NotelistState extends ConsumerState<Notelist> {
  
  @override
  Widget build(BuildContext context) {
    final note = ref.watch(noteStateProvider);
    return Scaffold(
      appBar: AppBar(
       title: Text("Note List"),
      ),
      body: Padding(   
         padding: EdgeInsets.symmetric( vertical: 10,horizontal: 10),
         child: ListView.builder(
          itemCount: note.length,
          itemBuilder: (context,index){
          final notelist = note[index];
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditNote(note: notelist)));
            },
            onLongPress: (){
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
                                        .read(noteStateProvider.notifier)
                                        .deleteNote(notelist);
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
                        });
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                 title: Text(notelist.title,style: TextStyle( fontSize: 20,color: Colors.black),),
                 subtitle: Text(notelist.date,style: TextStyle(color: Colors.red),),
                  trailing: IconButton( onPressed: (){
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
                                          .read(noteStateProvider.notifier)
                                          .deleteNote(notelist);
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
                          },);
            
                  },icon: Icon(Icons.delete),)
              ),
            ),
          );
         }),
      ),
    );
  }
}