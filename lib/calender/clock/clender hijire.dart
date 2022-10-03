// import 'package:flutter/material.dart';
// import 'package:hijri/hijri_calendar.dart';
// import 'package:new_pp/calender/clock/clenderabry.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class calenderHijiry extends StatefulWidget {
//
//   @override
//   State<calenderHijiry> createState() => _calenderHijiryState();
// }
//
// class _calenderHijiryState extends State<calenderHijiry> {
//
//
//   var hijri=HijriCalendar.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text('التقويم الهجري',),
//
//       ),
//       body:Column(
//         children: [
//
//           TableCalendar(
//               focusedDay: DateTime.now(),
//               firstDay: DateTime.utc(2000,9,16),
//               lastDay: DateTime.utc(3000,8,5)
//           ),
//           SizedBox(
//             height:90,
//           ),
//           RichText(
//             text: TextSpan(
//             children: [
//               TextSpan(
//                 text: hijri.hDay.toString(),
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 16.3,
//                 ),
//               ),
//               TextSpan(
//                 text: hijri.longMonthName,
//                 style: TextStyle(
//                   color: Colors.blue,
//
//                   fontSize: 16.3,
//                 ),
//               ),
//               TextSpan(
//                 text: '${hijri.hYear} AH',
//                 style: TextStyle(
//                   color: Colors.blue,
//
//                   fontSize: 16.3,
//                 ),
//               ),
//             ]
//           ),
//           ),
//           SizedBox(
//             height:90,
//           ),
//           TextButton(
//             onPressed: (){
//               Navigator.push(context ,
//                   MaterialPageRoute(builder:(context)=> calenderabry()));
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'التاريخ القبطي',
//                   style:TextStyle(
//                     fontSize: 30,
//                     backgroundColor: Colors.white.withOpacity(0.9),
//                   ),
//
//                 ),
//                 Icon(Icons.arrow_forward,size: 40,color: Colors.black,)
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
//
//



















import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

import 'clenderabry.dart';


class MyHomePage extends StatefulWidget {
 MyHomePage({this.title}) ;

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedDate = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('التقويم الهجري'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                selectedDate.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                selectedDate.fullDate(),
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height:90,
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context ,
                      MaterialPageRoute(builder:(context)=> calenderabry()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'التاريخ القبطى',
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _selectDate(context),
        tooltip: 'Pick Date',
        child: Icon(Icons.event),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final HijriCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1499
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}