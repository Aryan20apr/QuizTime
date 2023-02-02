import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/CategoryAlbum.dart';
import '../../Albums/QuizAlbum.dart';
import '../../Api.dart';
import 'QuizStudents.dart';
import 'StudentsScreen.dart';

class StudentsDetails extends StatefulWidget {
  StudentsDetails({Key? key, required this.categoryData}) : super(key: key);
  CategoryData categoryData;
  @override
  State<StudentsDetails> createState() => _StudentsDetailsState();
}

class _StudentsDetailsState extends State<StudentsDetails> {
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    UserProvider provider = Provider.of<UserProvider>(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
            //titleTextStyle: TextStyle(color:Theme.of(context).appBarTheme.foregroundColor,fontWeight: FontWeight.bold,fontSize: 14.sp ),
            title: Text('Your Classroom',style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).appBarTheme.foregroundColor),),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.school,color: isDarkMode?Theme.of(context).appBarTheme.foregroundColor:Colors.black,),
                ),
                Tab(
                  icon: Icon(Icons.score_rounded,color: isDarkMode?Theme.of(context).appBarTheme.foregroundColor:Colors.black),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Students(
                categoryData: widget.categoryData,
              ),
              MarksTab(
                userid: provider.id,
                categoryid: widget.categoryData.cid,
              )
            ],
          ),
        ));
  }
}

class MarksTab extends StatefulWidget {
  MarksTab({Key? key, required this.userid, required this.categoryid})
      : super(key: key);
  int? userid, categoryid;
  @override
  State<MarksTab> createState() => _MarksTabState();
}

class _MarksTabState extends State<MarksTab> {
  late Future<QuizAlbum> futurequiz;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //category=CategoryData.fromJson(widget.category);
    //quizzes=getQuizes();
    futurequiz =
        API().getAllQuizzesOfCategoryByUser(widget.userid, widget.categoryid);
  }

  List<List<Color>> colorListAdmin = [
    [Colors.yellow, Colors.deepOrange],
    [
      Colors.tealAccent,
      Colors.greenAccent.shade400,
    ]
  ];
  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return FutureBuilder(
        future: futurequiz,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuizAlbum quizAlbum = snapshot.data!;
            List<QuizData> quizData = quizAlbum.data!;
            return GridView.builder(physics: BouncingScrollPhysics(),
                itemCount: quizData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.white.withOpacity(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        borderRadius:BorderRadius.circular(20) ,
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (route)=>QuizStudents(quizid: quizData[index].qid)));
                        },
                        splashFactory: InkRipple.splashFactory,
                        enableFeedback: true,
                        excludeFromSemantics: true,
                        splashColor: Colors.white38,
                        focusColor: Colors.grey.shade300,
                        child: Container(
                          height: 30.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: quizData[index]!.active!
                                      ? colorListAdmin[1]
                                      : colorListAdmin[0]),
                              /*color: Colors.green,*/ borderRadius:
                                  BorderRadius.circular(20)),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${quizData[index].title}',textAlign: TextAlign.center,style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.white,fontSize: 14.sp)),),
                                Text('Number of Students Attempted',textAlign: TextAlign.center,style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.white,fontSize: 14.sp)),),
                                Align(alignment: Alignment.bottomRight,child: Icon(FontAwesomeIcons.arrowRight,color: Colors.white,))
                              ],

                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Container(
                height: 10.h,
                width: 10.w,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballGridBeat,
                  colors: [
                    Colors.red,
                    Colors.blue,
                    Colors.yellow,
                    Colors.green,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              ),
            );
          }
        });
  }
}


