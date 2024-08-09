import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust the size of the containers
    double screenWidth = MediaQuery.of(context).size.width;
    double containerSize = screenWidth / 6; // Adjust this ratio as needed

    String hours = _currentTime.hour.toString().padLeft(2, '0');
    String minutes = _currentTime.minute.toString().padLeft(2, '0');
    String seconds = _currentTime.second.toString().padLeft(2, '0');
    String amPm = _currentTime.hour >= 12 ? 'PM' : 'AM';
    String formattedDate = DateFormat.yMMMMd().format(_currentTime);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Your Time'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Time',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeContainer(hours, 'Hours', containerSize),
                  SizedBox(width: 10),
                  _buildTimeContainer(minutes, 'Minutes', containerSize),
                  SizedBox(width: 10),
                  _buildTimeContainer(seconds, 'Seconds', containerSize),
                  SizedBox(width: 10),
                  _buildAmPmContainer(amPm, containerSize / 2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeContainer(String value, String label, double size) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size / 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildAmPmContainer(String value, double size) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size / 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'AM/PM',
          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
