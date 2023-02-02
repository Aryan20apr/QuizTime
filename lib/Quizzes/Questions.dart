import 'package:quiztime/Albums/QuizResultAlbum.dart';
import 'package:quiztime/provider/OptionProvider.dart';
import 'package:quiztime/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import '../Admin/Questions/UpdateQuestion.dart';
import '../Albums/QuestionAlbum.dart';
import '../Albums/QuizAlbum.dart';
import '../Api.dart';
import 'QuizResult.dart';
class QuizQuestions extends StatefulWidget {
  QuizQuestions({Key? key,required this.quiz}) : super(key: key);
  QuizData quiz;
  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {

  late Future<QuestionAlbum>futurequestions;
  @override
  void initState()
  {
    super.initState();
    futurequestions=getQuestions(widget.quiz!.qid!);
  }
  Future<QuestionAlbum> getQuestions(int qid)
  {
    API api=API();
    return  api.getQuestionsofQuiz(qid);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white, //Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar( backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text('${widget.quiz.title}',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),),

        body: FutureBuilder(
            future: Future.wait([futurequestions]),
            builder:(context,snapshot){
              if(snapshot.hasData)
              {
                QuestionAlbum questionAlbum=snapshot.data![0];
                return Questions(questionAlbum:questionAlbum,quiz: widget.quiz,);
              }
              else
              {
                return Center(
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballGridBeat,
                      colors: [Colors.red,Colors.blue,Colors.yellow,Colors.green,Colors.orange,Colors.purple],
                    ),
                  ),
                );
              }
            }
        ),
      ));
  }
}
class Questions extends StatefulWidget {
  Questions({Key? key,required this.questionAlbum,required this.quiz}) : super(key: key);
  QuestionAlbum questionAlbum;
  QuizData quiz;
  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  late Future<QuestionAlbum >futureQuestions;
   late CountdownTimerController timerController;
   @override
   void initState()
   {

     String time=widget.quiz.quizDuration!;
     int hrs=int.parse(time.substring(0,2));
     int minutes=int.parse(time.substring(3,5));
     int seconds=int.parse(time.substring(6));
     //DateTime datetime=DateTime.parse(widget.quiz.quizDuration!);

     timerController=CountdownTimerController(endTime: DateTime.now().millisecondsSinceEpoch + hrs*60*60*1000+minutes*60*1000+seconds*1000);
   }
  API api=API();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch

    futureQuestions=api.getQuestionsofQuiz(widget.quiz.qid!);
    Future.wait([futureQuestions]).then((value) =>
        setState(()
        {
          widget.questionAlbum=value[0];}));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
  List<Color> colorListDark=[Colors.amber,Colors.amberAccent];
  int attempted=0;
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),color: isDarkMode?Colors.white:Color(0xFF2D2B55)),
          height: 15.h,
          child: Column(
            children: [
              Expanded(
                flex:2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Remaining Time:",style: TextStyle(color: isDarkMode==false?Colors.white:Color(0xFF2D2B55) /*Theme.of(context).textTheme.headlineLarge!.color*/,fontSize: 15.sp),),
                    ),
                    CountdownTimer(
                      textStyle: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: isDarkMode==false?Colors.white:Color(0xFF2D2B55)),
                      controller: timerController,
                      onEnd: ()async{
                        QuizResultAlbum quizResult=await api.submitQuiz(widget.quiz.qid!,widget.questionAlbum.data!);
                        //showDialog(context: context, builder: builder)
                      }
                      ,
                    )
                  ],
                ),
              ),
              ElevatedButton(onPressed: ()async{
                showModalBottomSheet(context: context, builder: (context){
                  return Container(height: 30.h, decoration: BoxDecoration(

                      color: isDarkMode==false?Colors.white:Color(0xFF2D2B55),//Theme.of(context).scaffoldBackgroundColor,
                      /*gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                    ],
                                  ),*/
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(

                              color: isDarkMode?Colors.white:Color(0xFF2D2B55),//Theme.of(context).scaffoldBackgroundColor,
                              /*gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.black,
                                        Colors.black12,
                                      ],
                                    ),*/
                              borderRadius: BorderRadius.all( Radius.circular(10))),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text(
                              'Do you wish to submit your quiz ?',style: TextStyle(color: isDarkMode?Colors.black:Colors.white/*Theme.of(context).textTheme.displayMedium?.color*/,fontSize: 13.sp,),textAlign: TextAlign.center,),
                            Text(
                              'Number of Questions Attempted:$attempted',style: TextStyle(color: isDarkMode?Colors.black:Colors.white/*Theme.of(context).textTheme.displayMedium?.color*/,fontSize: 13.sp,),textAlign: TextAlign.center,),

                              Text(
                                'Total Number of Questions:${widget.questionAlbum.data!.length}',style: TextStyle(color: isDarkMode?Colors.black:Colors.white/*Theme.of(context).textTheme.displayMedium?.color*/,fontSize: 13.sp,),textAlign: TextAlign.center,),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("Cancel",style: TextStyle(fontSize: 12.sp))),
                                  TextButton(onPressed: ()async{
                                    //UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                                    //CategoryAlbum responde=await API().enrollInSubject(provider.id, categoryData.cid!);
                                    QuizResultAlbum quizResult=await api.submitQuiz(widget.quiz.qid!,widget.questionAlbum.data!);
                                    if(quizResult.success==true)
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (route)=>QuizResult(quizResult:quizResult)));
                                  }, child: Text("Submit",style: TextStyle(fontSize: 12.sp)))
                                ],
                              )
                            ],),
                        ),
                      ),
                    ),);
                });
              }, child: Text("Submit",style: TextStyle(fontSize: 12.sp),),style:ElevatedButton.styleFrom(backgroundColor: Colors.green))
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Container(
              decoration: BoxDecoration(color: isDarkMode==false?Colors.white:Color(0xFF2D2B55),borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ),),

              width:100.w,
              child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: widget.questionAlbum.data!.length, itemBuilder: (BuildContext context, int index) {
                List<QuestionData> questions=widget.questionAlbum.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                  child: Neumorphic(
                    style:  NeumorphicStyle(intensity: isDarkMode?0:50,shape: NeumorphicShape.convex,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),),
                    child: Container(
                      height: 50.h,
                        width: 70.w,
                        decoration:BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: colorListDark,
                        ),borderRadius: BorderRadius.circular(10),/*border: Border.all(width: 2,color: Colors.black)*/),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LayoutBuilder(
                            builder: (context,constraints) {
                              return ChangeNotifierProvider<OptionProvider>(
                                create: (BuildContext context) { return  OptionProvider(); },
                                child: Consumer<OptionProvider>(
                                  builder: (BuildContext context,optionProvider,_) {
                                    if(widget.questionAlbum.data?[index].givenAnswer==questions[index].option1)
                                      {
                                        optionProvider.optionSelected=1;
                                      }
                                    else if(widget.questionAlbum.data?[index].givenAnswer==questions[index].option2)
                                    {
                                      optionProvider.optionSelected=2;
                                    }
                                    else if(widget.questionAlbum.data?[index].givenAnswer==questions[index].option3)
                                    {
                                      optionProvider.optionSelected=3;
                                    }
                                    else if(widget.questionAlbum.data?[index].givenAnswer==questions[index].option4)
                                    {
                                      optionProvider.optionSelected=4;
                                    }
                                    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${questions[index].content}',style:  GoogleFonts.aBeeZee(fontSize: 15.sp,fontWeight: FontWeight.bold,)),
                                      InkWell(
                                        onTap:(){
                                          if(optionProvider.optionSelected==-1)
                                            {
                                              attempted++;
                                            }
                                            optionProvider.changeSelection(1);
                                            widget.questionAlbum.data?[index].givenAnswer=questions[index].option1;
                                        },
                                        child: Container(width: constraints.maxWidth*0.9,decoration: BoxDecoration(color: optionProvider.optionSelected==1?kSelectedAnswer:Colors.white,border: Border.all(width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10),),child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('A. ${questions[index].option1}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                                        )),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          if(optionProvider.optionSelected==-1)
                                          {
                                            attempted++;
                                          }
                                          optionProvider.changeSelection(2);
                                          widget.questionAlbum.data?[index].givenAnswer=questions[index].option2;
                                        },
                                        child: Container(width: constraints.maxWidth*0.9,decoration: BoxDecoration(color: optionProvider.optionSelected==2?kSelectedAnswer:Colors.white,border: Border.all(width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10)),child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('B. ${questions[index].option1}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                                        )),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          if(optionProvider.optionSelected==-1)
                                          {
                                            attempted++;
                                          }
                                          optionProvider.changeSelection(3);
                                          widget.questionAlbum.data?[index].givenAnswer=questions[index].option3;
                                        },
                                        child: Container(width: constraints.maxWidth*0.9,decoration: BoxDecoration(color: optionProvider.optionSelected==3?kSelectedAnswer:Colors.white,border: Border.all(width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10)),child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('C. ${questions[index].option3}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                                        )),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          if(optionProvider.optionSelected==-1)
                                          {
                                            attempted++;
                                          }
                                          optionProvider.changeSelection(4);
                                          widget.questionAlbum.data?[index].givenAnswer=questions[index].option4;
                                        },
                                        child: Container(width: constraints.maxWidth*0.9,decoration: BoxDecoration(color: optionProvider.optionSelected==4?kSelectedAnswer:Colors.white,border: Border.all(width: 2.0,style: BorderStyle.solid),borderRadius: BorderRadius.circular(10)),child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('D. ${questions[index].option4}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                                        )),
                                      ),
                                      Align(alignment: Alignment.bottomRight,child: TextButton(style: TextButton.styleFrom(primary: Colors.grey),child: Text('Clear',style: TextStyle(color: Colors.blue,fontSize: 12.sp),),onPressed: (){

                                        if(optionProvider.optionSelected!=-1)
                                        {
                                          attempted--;
                                        }
                                        optionProvider.changeSelection(-1);
                                        widget.questionAlbum.data?[index].givenAnswer=null;
                                      },),)
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(top:8.0,left: 8.0),
                                      //       child: Align(alignment: Alignment.centerLeft,child: Text('Answer:${questions[index].answer}',style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),)),
                                      //
                                      //     ),
                                      //
                                      //   ],
                                      // ),
                                    ],); },

                                )
                              );
                            }
                          ),
                        )
                    ),
                  ),
                ); },),
            ),
          ),
        ),
      ],
    );

  }
}