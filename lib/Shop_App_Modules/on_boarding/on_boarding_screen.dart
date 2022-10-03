import 'package:flutter/material.dart';
import 'package:new_pp/Shop_App_Modules/shop_login/login.dart';
import 'package:new_pp/shared/components/components.dart';
import 'package:new_pp/shared/network/local/cache_helper/cacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/styles/colors.dart';
class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
   this.image,
   this.title,
   this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var borderController=PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/shop.png',
        title: 'Enjoy ',
        body: 'the most exclusive and discounted offers',

        ),
    BoardingModel(
      image: 'assets/images/discount.png',
      body:" what you want with discount coupons and easy payment",
      title: 'Order',
    ),
    BoardingModel(
      image: 'assets/images/payment.png',
      body: 'your order within the specified time with easy delivery',
      title: 'Receive',
    ),

  ];

  bool isLast=false;
void submit(){

  CacheHelper.savedata(key:"onBoarding", value: true).then((value){
    if(value)
      {

        navigateAndFinish(context, shopLogin());
      }

  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: [
          TextButton(
              onPressed:submit,
              child:Text(
                'SKIP',

              ),
          ),
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              //ال pageView دي الصفحه اللى قبل تسجل الدخول اللى بتعرفك على التطبيق
              child: PageView.builder(
                onPageChanged: (int index){
                  if(index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }else
                      {
                        setState(() {
                          isLast=false;
                        });
                      }
                },
                controller: borderController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height:40.1,
            ),
            Row(
              children: [
                //دى علشان شكل التلت نقط اللى هتتحرك لما احرك الشاشات والنقط تتحرك معاها اسمها indacator

                SmoothPageIndicator(
                  controller:borderController,
                  //علشان شكل التلت نقط
                  effect:ExpandingDotsEffect(
                    dotColor:Colors.blueAccent,
                    activeDotColor:dafultColor,
                    dotHeight:15,
                    expansionFactor:3,
                    dotWidth:15,
                    spacing:5,
                  ),
                  count:boarding.length,
                ),

                Spacer(),//علشان يرمى اللى بعديه فى اخر الصفحه يعنى بيبعد اللى قبليه عن اللى بعديه
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }
                    borderController.nextPage(
                        duration: Duration(
                          milliseconds: 500
                        ),
                        //شكل النقله من صفحه الى التانيه
                        curve: Curves.easeOutSine,
                    );

                  },
                child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingForModel)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      Expanded(
        child: Image(
            image: AssetImage('${boardingForModel.image}')
        ),
      ),
      SizedBox(
        height:20.1,
      ),
      Text(''
          '${boardingForModel.title}',
        style: TextStyle(
            fontSize: 30.2
        ),
      ),
      SizedBox(
        height:20.1,
      ),
      Text(''
          '${boardingForModel.body}',
        style: TextStyle(
            fontSize: 15.1
        ),
      ),
      SizedBox(
        height:15.1,
      ),
    ],
  );
}