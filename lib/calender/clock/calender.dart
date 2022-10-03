import 'package:flutter/material.dart';
import 'package:new_pp/calender/clock/clender%20hijire.dart';
import 'package:table_calendar/table_calendar.dart';

class calender extends StatefulWidget {

  @override
  State<calender> createState() => _calenderState();
}

class _calenderState extends State<calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('التقويم الميلادى',),

      ),
      body:Column(
        children: [
          TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2000,9,16),
              lastDay: DateTime.utc(3000,8,5)
          ),
          SizedBox(
            height:90,
          ),
          TextButton(
            onPressed: (){
               Navigator.push(context ,
                   MaterialPageRoute(builder:(context)=> MyHomePage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'التاريخ الهجري',
                  style:TextStyle(
                    fontSize: 30,
                    backgroundColor: Colors.white.withOpacity(0.5),
                  ),

                ),
                Icon(Icons.arrow_forward,size: 40,color: Colors.black,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
