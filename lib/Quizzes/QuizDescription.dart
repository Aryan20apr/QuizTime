import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:sizer/sizer.dart';

import '../Albums/QuizAlbum.dart';
import 'Questions.dart';
class QuizDescription extends StatelessWidget {
   QuizDescription({Key? key,required this.quiz}) : super(key: key);
  QuizData quiz;
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar( backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text('${quiz.title}',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),),
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
                        child: Text("Read the below instructions carefully: ",style:TextStyle(color:Theme.of(context).textTheme.headlineMedium!.color,fontSize: 14.sp,fontWeight: FontWeight.bold)),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: '1. There are'),
                            TextSpan(
                                text: ' ${quiz.numberOfQuestions}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' questions.'),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: '2. Maximum marks for the quiz are'),
                            TextSpan(
                              text: ' ${quiz.maxMarks}.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: '3. Duration of this quiz is'),
                            TextSpan(
                              text: ' ${quiz.quizDuration}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: '4. The quiz will be auto submitted as soon as the duration of the quiz is complete.'),


                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),
                          children: <TextSpan>[
                            TextSpan(text: '5. Submit the quiz by tapping'),
                            TextSpan(
                              text: ' Submit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' button.',

                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),

                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (route)=>QuizQuestions( quiz: quiz,)));
                        }, child: Text('Start Quiz'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
                      )
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
