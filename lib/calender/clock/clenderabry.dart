import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calender.dart';

class calenderabry extends StatefulWidget {

  @override
  State<calenderabry> createState() => _calenderabryState();
}

class _calenderabryState extends State<calenderabry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('التقويم القبطى',),
      ),
      body:Column(
        children: [
          TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2000,9,16),
              lastDay: DateTime.utc(3000,8,5)
          ),

        ],
      ),
    );
  }
}
