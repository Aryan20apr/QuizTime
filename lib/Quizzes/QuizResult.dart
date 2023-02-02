import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sizer/sizer.dart';

import '../Albums/QuizResultAlbum.dart';
class QuizResult extends StatelessWidget {
   QuizResult({Key? key,required this.quizResult}) : super(key: key);
  QuizResultAlbum quizResult;
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar( backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text('Quiz Result',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),),
        body:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                width: 90.w,
                constraints: BoxConstraints(minHeight: 100.h),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(width: 5,color: Colors.black),color: isDarkMode?Colors.white:Colors.grey.shade200),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Your Quiz Result ",style:TextStyle(color:Theme.of(context).textTheme.headlineMedium!.color,fontSize: 14.sp,fontWeight: FontWeight.bold)),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: 'Your Marks'),
                            TextSpan(
                              text: ' ${quizResult.data!.marks}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: 'Total questions attempted'),
                            TextSpan(
                              text: ' ${quizResult.data!.attempted}.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: 'Correct Answers'),
                            TextSpan(
                              text: ' ${quizResult.data!.correct}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: 'Result'),
                            TextSpan(
                              text: (quizResult!.success==true)?' PASS':' FAIL',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 20.h,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
