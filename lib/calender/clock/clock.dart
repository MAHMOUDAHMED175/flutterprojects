import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_pp/calender/clock/calender.dart';
import 'package:table_calendar/table_calendar.dart';

class clock extends StatefulWidget {
  @override
  State<clock> createState() => _clockState();
}

class _clockState extends State<clock> {
  double minutesAngle=0;
  double hoursAngle=0;
  double secondAngle=0;
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer=Timer.periodic(Duration(milliseconds: 500), (timer) {

      final now =DateTime.now();
      setState(() {
        print(now);
        secondAngle= ( pi / 30 ) * now.second;
        minutesAngle=  pi / 30  * now.minute;
        hoursAngle= ( pi / 6* now.hour )+(pi/45*minutesAngle);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,0),
      color: Color.fromRGBO(10, 10,10, 1),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 245,
            height:245,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white,width: 10),
              borderRadius: BorderRadius.circular(150),
            ),
            //clock
            child:Stack(
              children:<Widget> [
                Container(
                    alignment:  Alignment(0, 0),
                    child: Image.asset('assets/images/clock1.png'),

                ),
                //second
                Transform.rotate(
                  angle: secondAngle,
                  child: Container(
                    alignment: Alignment(0,-0.4),
                    child: Container(
                      height: 98,
                      width: 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                //minutes
                Transform.rotate(
                  child: Container(
                    alignment: Alignment(0,-0.3),
                    child: Container(
                      height: 80,
                      width: 7,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  angle: minutesAngle,
                ),
                //hours
                Transform.rotate(
                 angle: hoursAngle,
                  child: Container(
                    alignment: Alignment(0,-0.2),
                    child: Container(
                      height: 60,
                      width: 12,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                //Dot
                Container(
                  alignment: Alignment(0,0),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
            ),
          SizedBox(
            height: 200,
          ),
          TextButton(
            onPressed: (){
              Navigator.push(context ,
              MaterialPageRoute(builder:(context)=> calender()));
            },
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'التاريخ',
                style:TextStyle(
                  fontSize: 50,
                  backgroundColor: Colors.black.withOpacity(0.9),
                ),

                ),
                Icon(Icons.arrow_forward,size: 50,color: Colors.white,)
              ],
            ),
          ),
        ],
      ),

    );
  }
}
