import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quickpad/Models/todomodel.dart';
import 'package:quickpad/Notifiers/timenotifier.dart';
import 'package:quickpad/Notifiers/todonotifier.dart';
import 'package:quickpad/Screens/clock.dart';
import 'package:quickpad/Screens/note.dart';
import 'package:quickpad/Screens/notelist.dart';
import 'package:quickpad/Screens/todolist.dart';
import 'package:quickpad/Screens/userguide.dart';

class Homescreen extends ConsumerStatefulWidget {
  Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  late TextEditingController _tdTitle;
  late TextEditingController _tdPurpose;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tdTitle = TextEditingController();
    _tdPurpose = TextEditingController();
  }

  @override
  void dispose() {
    _tdTitle.dispose();
    _tdPurpose.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final dateTimeNotifier = ref.watch(dateTimeProvider.notifier);
    final formattedDateTime = dateTimeNotifier.getFormattedDateTime();
    final todo = ref.watch(todoProvider);

    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.jpg', width: 28),
            Text(
              "uickPad",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: screenHeight * 0.20,
                width: double.infinity,
                child: Image.asset('assets/view2.jpg', fit: BoxFit.cover),
              ),
              Positioned(
                bottom: -screenHeight * 0.07,
                left: (screenWidth - screenWidth * 0.90) / 2,
                child: GestureDetector(
                  onDoubleTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Clock()));
                  },
                  child: Card(
                    shape: CircleBorder(),
                    elevation: 10,
                    child: Container(
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          formattedDateTime,
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.08),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            child: Card(
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: screenHeight * 0.12,
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    'assets/view1.webp',
                    'assets/view2.jpg',
                    'assets/view3.jpg',
                    'assets/view4.jpg',
                    'assets/view5.jpg',
                    'assets/view6.jpg',
                    'assets/view7.jpg',
                    'assets/view8.jpg',
                    'assets/view9.jpg',
                  ]
                      .map((asset) => Image.asset(asset, fit: BoxFit.cover))
                      .toList(),
                  options: CarouselOptions(autoPlay: true),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircleAvatar('Todo', () {
                _showTaskDialog(context);
              }),
              _buildCircleAvatar('Note', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNote()));
              }),
              _buildCircleAvatar('Tasks', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Todolist()));
              }),
              _buildCircleAvatar('Notes', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Notelist()));
              }),
            ],
          ),
          SizedBox(height: 25),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context, index) {
                  final td = todo[index];
                  return GestureDetector(
                    onLongPress: () {
                      _showDeleteDialog(context, td);
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          td.title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          td.purpose,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: Text(
                          td.date,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Clock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Guide',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Todolist()));
              break;
            case 1:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Notelist()));
              break;
            case 2:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Clock()));
              break;
            case 3:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserGuideScreen()));
              break;
          }
        },
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            
            decoration: BoxDecoration(
              color: Colors.blue,
              
            ),
            child: Text(
              'User Guide',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.edit,
            text: 'Tap to Edit Note',
          ),
          _buildDrawerItem(
            icon: Icons.delete,
            text: 'Long Press to Delete Note',
          ),
          _buildDrawerItem(
            icon: Icons.check_box,
            text: 'Tasks (To-do)',
          ),
          _buildDrawerItem(
            icon: Icons.access_time,
            text: 'Double Tap the Clock to See Time',
          ),
          Divider(),
          ListTile(
            title: Text('Developed by Nathan James'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      {required IconData icon, required String text}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        // Add navigation or other functionality here
      },
    );
  }

  Widget _buildCircleAvatar(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.blue[700],
        radius: MediaQuery.of(context).size.width * 0.085,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
      ),
    );
  }

  void _showTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Task",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tdTitle,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
              ),
              TextField(
                controller: _tdPurpose,
                decoration: InputDecoration(
                  labelText: "Purpose",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final newTodo = Todomodel(
                  title: _tdTitle.text,
                  purpose: _tdPurpose.text,
                  date: DateFormat.yMMMd().format(DateTime.now()),
                );
                ref.read(todoProvider.notifier).addTodo(newTodo);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, Todomodel todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Delete Task",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                ref.read(todoProvider.notifier).removeTodo(todo);
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
