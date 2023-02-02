import 'package:quiztime/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';

import '../Albums/QuizHistoryAlbumStudent.dart';
class StudentQuizHistory extends StatefulWidget {
  const StudentQuizHistory({Key? key}) : super(key: key);

  @override
  State<StudentQuizHistory> createState() => _StudentQuizHistoryState();
}

class _StudentQuizHistoryState extends State<StudentQuizHistory> {
  late Future<StudentHistoryAlbum> futurehistory;
  API api=API();
  @override
  void initState()
  {
    print('History initState');
    super.initState();
    futurehistory=getHistory();
  }
  Future<StudentHistoryAlbum> getHistory()async
  {print('getHistory()');
    return await api.quizHistory();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
        future: futurehistory,
      builder: ( context,snapshot) {
          print('Quiz History Snapshot has data ${snapshot.hasData}');
          if(snapshot.hasData)
            {
            StudentHistoryAlbum quizHistory=snapshot.data!;
            List<HistoryStudent> studentHistory=quizHistory.data!;
            print('studentHistory length=${studentHistory.length}');
            var brightness=SchedulerBinding.instance.window.platformBrightness;
            bool isDarkMode=brightness==Brightness.dark;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                    child: Neumorphic(
                      style: NeumorphicStyle( shape: NeumorphicShape.concave,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2.0,color: isDarkMode?Colors.white:Colors.black),
                          borderRadius: BorderRadius.circular(20),
                            color: isDarkMode?Colors.white:Colors.grey.shade200),
                        child: ListTile(leading:Text('Quiz Id',style: TextStyle(color: isDarkMode?Colors.black:Colors.black,fontSize: 12.sp),) ,
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                              'Quiz Details',style: TextStyle(color: isDarkMode?Colors.black:Colors.black,fontSize: 12.sp)),
                        ),
                        trailing: Text('Marks',style: TextStyle(color: isDarkMode?Colors.black :Colors.black,fontSize: 12.sp))),
                      ),
                    )/*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text('Quiz Id',style: TextStyle(color: isDarkMode?Colors.white:Colors.black,fontSize: 12.sp),),Text(
                          'Quiz Details',style: TextStyle(color: isDarkMode?Colors.white:Colors.black,fontSize: 10.sp)),
                        Text('Marks',style: TextStyle(color: isDarkMode?Colors.white:Colors.black,fontSize: 12.sp),),
                        ],
                    ),*/
                  ),
                  Container(
                    height: 90.h,
                    child: ListView.builder(physics:BouncingScrollPhysics(),itemCount: studentHistory.length, itemBuilder: (context,index){
                      HistoryStudent history=studentHistory[index];
                      //Icon isEnabledIcon=userData.enabled==true?Icon(Icons.check_circle_rounded,color: Colors.green,):Icon(Icons.cancel,color: Colors.red,);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Neumorphic(
                          style: NeumorphicStyle( shape: NeumorphicShape.concave,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),),
                          child: Container(
                              decoration: BoxDecoration(

                                color: isDarkMode?Colors.white:Colors.deepPurple,
                                /*gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.black,
                                          Colors.black12,
                                        ],
                                      ),*/
                                borderRadius: BorderRadius.circular(20),
                                /* border:
                                          Border.all(width: 2, color: Colors.blueAccent)*/),
                              height: 10.h,
                              width: 90.w,
                              child: Material(
                                color: Colors.white.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {
                                      /* UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                                      Navigator.push(context, MaterialPageRoute(builder: (route)=>Students(categoryData: widget.categories.data![index])));*/
                                    },
                                    splashFactory: InkRipple.splashFactory,
                                    enableFeedback: false,
                                    excludeFromSemantics: false,
                                    splashColor: Colors.white38,
                                    focusColor: Colors.grey.shade300,
                                    //highlightColor: Colors.grey.shade300,
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Text('${history.quiz!.qid}',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 15.sp),),
                                      title: Text(
                                          '${history.quiz!.title} ',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 13.sp)),
                                      subtitle: Text(
                                          '${history.quiz!.category!.title}',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 10.sp)),
                                      trailing: Text('${history.marks}/${history.quiz!.maxMarks}',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 13.sp)),
                                    )
                                  /*Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("${widget.users.data![index].nickname}",style: GoogleFonts.alegreyaSc(
                                            color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),



                                      ],
                                    ),*/
                                ),
                              )),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );

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
    },

      ),

    ));
  }
}


