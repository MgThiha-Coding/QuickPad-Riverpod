import 'package:flutter/material.dart';

class UserGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Guide'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Tap to Edit Note'),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Long Press to Delete Note'),
            ),
            ListTile(
              leading: Icon(Icons.check_box),
              title: Text('Tasks (To-do)'),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Double Tap the Clock to See Time'),
            ),
            Divider(),
           
          ],
        ),
      ),
    );
  }
}
