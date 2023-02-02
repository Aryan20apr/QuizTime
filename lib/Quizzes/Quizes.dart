import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Albums/QuizAlbum.dart';
import '../Api.dart';
import '../util/Constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Questions.dart';
import 'QuizDescription.dart';


//late Future <Map<String, dynamic>> quizzes;

class Quizes extends StatefulWidget {
   Quizes({Key? key,required this.category,required this.userid}) : super(key: key);
  CategoryData category;
  int userid;
  @override
  State<Quizes> createState() => _QuizesState();
}

class _QuizesState extends State<Quizes> {
  late Future<QuizAlbum >futurequiz;

 // late CategoryData category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //category=CategoryData.fromJson(widget.category);
    //quizzes=getQuizes();
    futurequiz=API().getAllCActiveQuizesByCategory(widget.category.cid);
  }


  Future<QuizAlbum> getQuizes()async
  {
    API api=API();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    int? roleId=preferences.getInt(Constants.roleId);
    //CategoryData category=CategoryData.fromJson(widget.category);
    print("Category id= ${widget.category.cid}");
    if(roleId==Constants.student)

    return await api.getAllCActiveQuizesByCategory(widget.category.cid);
    else
      return await api.getAllQuizesByCategory(widget.category.cid);
    //quizzes=await api.getAllQuizzes();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar( backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('${widget.category.title!}',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: FutureBuilder(
           future:Future.wait([/*quizzes*/futurequiz]),
          builder: (context,snapshot) {
            if(snapshot.hasData)
            {

              QuizAlbum quiz=snapshot.data![0];
              //Constants.quizes=snapshot.data![0]['data'];
              return QuizScreenContent(quiz:quiz);
            }else
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
class QuizScreenContent extends StatefulWidget {
    QuizScreenContent({Key? key,required this.quiz}) : super(key: key);
  QuizAlbum quiz;

  @override
  State<QuizScreenContent> createState() => _QuizScreenContentState();
}

class _QuizScreenContentState extends State<QuizScreenContent> {
  late Future<QuizAlbum >futurequiz;

  API api=API();
  void _onRefresh() async{
    // monitor network fetch

    futurequiz= api.getAllCActiveQuizesByCategory(widget.quiz.data![0]!.category!.cid);
    Future.wait([futurequiz]).then((value) =>
    setState(()
        {
    widget.quiz=value[0];}));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  /*void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }*/
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  List<List<Color>> colorListStudent=[[
    Colors.blue.shade200,
    Colors.blue.shade700
  ],[Colors.red.shade200,Colors.red.shade700],[Colors.green.shade200,Colors.green.shade700],[Colors.purple.shade200,Colors.purple.shade700]];
  List<List<Color>> colorListAdmin=[[Colors.red.shade200,Colors.red.shade700],[Colors.green.shade200,Colors.green.shade700]];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        body: SingleChildScrollView(

          child: Container(
            height: MediaQuery.of(context).size.height-kBottomNavigationBarHeight-3.h,
            width: 100.w,
            child: SmartRefresher(
              enablePullDown: true,
              //enablePullUp: true,
              onRefresh: _onRefresh,
             // onLoading: _onLoading,
              header: WaterDropMaterialHeader(color:Colors.blueAccent,backgroundColor: Colors.white,),
              controller: _refreshController,
              child: ListView.builder(physics: BouncingScrollPhysics(),itemCount:widget.quiz.data!.length ,itemBuilder: ( context, int index)
              {
                /*return ExpandableNotifier(  // <-- Provides ExpandableController to its children
                      child: Container(
                        height: 20.h,
                        width: 80.w,
                        color: Colors.redAccent,
                        child: Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
                        collapsed: ExpandableButton(  // <-- Expands when tapped on the cover photo
                        child: Text('${Constants.categories[index]['title']}',style: TextStyle(color: Colors.black),),
                  ),
                  expanded: Column(
                  children: [

                ExpandableButton(       // <-- Collapses when tapped on
                child: Text("Back"),
                ),
                ]
                ),
                ),
                      ),
                 );*/
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration:BoxDecoration(gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: colorListStudent[index%4],
                      ),borderRadius: BorderRadius.circular(20),border: Border.all(width: 5,color: Colors.black)),
                      height: 22.h,
                      width: 85.w,
                      child:Material(
                        color: Colors.white.withOpacity(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          borderRadius:BorderRadius.circular(20) ,
                          onTap: ()
                          {Navigator.push(context, MaterialPageRoute(builder: (route)=>QuizDescription(quiz: widget.quiz.data![index],)));
                                // Navigator.push(context, MaterialPageRoute(builder: (route)=>QuizQuestions(quiz: widget.quiz.data![index],)));
                          },
                          splashFactory: InkRipple.splashFactory,
                          enableFeedback: false,
                          excludeFromSemantics: false,
                          splashColor: Colors.white38,
                          focusColor: Colors.grey.shade300,
                          //highlightColor: Colors.grey.shade300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[
                              Text("Quiz id:${widget.quiz.data![index]?.qid}",style: GoogleFonts.laila(
                                color: Colors.white, fontSize: 11.sp,),textAlign: TextAlign.center,),
                              Text("${widget.quiz.data![index]?.title}",style: GoogleFonts.alegreyaSc(
                                  color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold)),
                              Text("${widget.quiz.data![index]?.description}",style: GoogleFonts.laila(
                                color: Colors.black, fontSize: 11.sp,)),
                              Text("Maximum marks:${widget.quiz.data![index]?.maxMarks}",style: GoogleFonts.laila(
                                color: Colors.black, fontSize: 11.sp,)),
                              Text("Number of Questions:${widget.quiz.data![index]?.numberOfQuestions}",style: GoogleFonts.laila(
                                color: Colors.black, fontSize: 11.sp,)),

                            ],
                          ),
                        ),
                      )
                  ),
                );
              },
              ),
            ),
          ),
        ),
      ),
    );
  }
}


