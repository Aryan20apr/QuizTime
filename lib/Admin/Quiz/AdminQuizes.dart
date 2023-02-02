

import 'package:quiztime/Admin/Albums/UpdateQuiz.dart';
import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Albums/QuizAlbum.dart';
import '../../Api.dart';
import '../../util/Constants.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import 'CreateQuiz.dart';
import 'UpdateQuiz.dart';


//late Future <Map<String, dynamic>> quizzes;

class AdminQuizes extends StatefulWidget {
  AdminQuizes({Key? key,required this.category,required this.userId}) : super(key: key);
 CategoryData category;
  int userId;
  @override
  State<AdminQuizes> createState() => _AdminQuizesState();
}

class _AdminQuizesState extends State<AdminQuizes> {
  late Future<QuizAlbum >futurequiz;

  //late CategoryData category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //category=CategoryData.fromJson(widget.category);
    //quizzes=getQuizes();
    futurequiz=API().getAllQuizzesOfCategoryByUser(widget.userId,widget.category.cid);
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('${widget.category.title}',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
      ),

      floatingActionButton: FloatingActionButton(elevation: 2,splashColor: Colors.white38,child: Icon(Icons.add,color:Colors.white),onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (route)=>CreateQuiz(category: widget.category,))); },

      ),
      body: FutureBuilder(

          future:Future.wait([/*quizzes*/futurequiz]),
          builder: (context,snapshot) {
            if(snapshot.hasData)
            {

              QuizAlbum quiz=snapshot.data![0];
              //Constants.quizes=snapshot.data![0]['data'];
              return QuizScreenContent(quiz:quiz,userId:widget.userId);
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
  QuizScreenContent({Key? key,required this.quiz,required this.userId}) : super(key: key);
  QuizAlbum quiz;
  int userId;
  @override
  State<QuizScreenContent> createState() => _QuizScreenContentState();
}

class _QuizScreenContentState extends State<QuizScreenContent> {
  late Future<QuizAlbum >futurequiz;

  API api=API();
  void _onRefresh() async{
    // monitor network fetch

    futurequiz=  api.getAllQuizzesOfCategoryByUser(widget.userId,widget.quiz.data![0]!.category!.cid);
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


  List<List<Color>> colorListAdmin=[[Colors.yellow,Colors.deepOrange],[Colors.tealAccent,Colors.greenAccent.shade400,]];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


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
                List<QuizData> quizList=widget.quiz!.data!;
                bool isActive=quizList[index]!.active!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration:BoxDecoration(gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: quizList[index]!.active!?colorListAdmin[1]:colorListAdmin[0],
                      ),borderRadius: BorderRadius.circular(20),border: Border.all(width: 5,color: Colors.black)),
                      height: 15.h,
                      width: 85.w,
                      child:Material(
                        color: Colors.white.withOpacity(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onLongPress: (){
                            showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                              title: const Text('Delete Quiz'),
                              content: const Text('Do you wish to delete the quiz'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {


                                    Navigator.pop(context, 'Cancel');

                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: ()async {
                                      Map<String,dynamic > response=await api.deleteQuiz(quizList[index].qid);
                                    //API().updateQuiz(QuizData( qid:quizList[index].qid, title:quizList[index].title,description:quizList[index].description,maxMarks:quizList[index].maxMarks, numberOfQuestions:quizList[index].numberOfQuestions, active:isActive, category:CategoryData(cid:quizList[index].category?.cid),user: UserData(id:provider.id)));
                                      if(response['success'])
                                        {

                                      Fluttertoast.showToast(msg: "Quiz Deleted Successfully");
                                        Navigator.pop(context);
                                      _onRefresh();}

                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),);
                          },
                          borderRadius:BorderRadius.circular(20) ,
                          onTap: ()
                          {
                                      Navigator.push(context, MaterialPageRoute(builder: (route)=>UpdateQuiz(quiz:widget!.quiz!.data![index]))).then((value) => _onRefresh());
                          },
                          splashFactory: InkRipple.splashFactory,
                          enableFeedback: false,
                          excludeFromSemantics: false,
                          splashColor: Colors.white38,
                          focusColor: Colors.grey.shade300,
                          //highlightColor: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: LayoutBuilder(
                              builder: (context,constraint) {
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Quiz id:${quizList[index]?.qid}",style: GoogleFonts.laila(
                                            color: Colors.white, fontSize: 11.sp,),textAlign: TextAlign.center,),
                                          Text("${quizList[index]?.title}",style: GoogleFonts.alegreyaSc(
                                              color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold)),
                                       /*   Text("${{quizList[index]?.description}",style: GoogleFonts.laila(
                                            color: Colors.black, fontSize: 11.sp,)),*/
                                          Text("Maximum marks:${quizList[index]?.maxMarks}",style: GoogleFonts.laila(
                                            color: Colors.black, fontSize: 11.sp,)),
                                          Text("Number of Questions:${quizList[index]?.numberOfQuestions}",style: GoogleFonts.laila(
                                            color: Colors.black, fontSize: 11.sp,)),

                                        ],
                                      ),

                                    ),
                                    Expanded(
                                      flex: 1,
                                        child: Container(height: constraint.maxHeight*0.3,
                                            child: AnimatedToggleSwitch.dual(onChanged: (value){
                                              UserProvider provider=Provider.of<UserProvider>(context,listen:false);
                                              if(value==QuizActive.Active)
                                                {

                                                  showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Update Quiz'),
                                                    content: const Text('Do you wish to enable the quiz'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {


                                                          Navigator.pop(context, 'Cancel');
                                                        },
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          isActive=true;
                                                           API().updateQuiz(QuizData( qid:quizList[index].qid, title:quizList[index].title,description:quizList[index].description,maxMarks:quizList[index].maxMarks, numberOfQuestions:quizList[index].numberOfQuestions, active:isActive, category:CategoryData(cid:quizList[index].category?.cid)),provider.id);

                                                          Navigator.pop(context, 'OK');
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),);
                                                  if(isActive)
                                                    {
                                                      setState(() {

                                                        isActive=true;
                                                        quizList[index]!.active=true;
                                                      });
                                                    }
                                                }
                                              else
                                                {
                                                  setState(() {
                                                    quizList[index].active=false;
                                                    isActive=false;
                                                  });
                                                  showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                                                    title: const Text('Update Quiz'),
                                                    content: const Text('Do you wish to disable the quiz'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {


                                                          Navigator.pop(context, 'Cancel');
                                                        },
                                                        child: const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {

                                                          API().updateQuiz(QuizData( qid:quizList[index].qid, title:quizList[index].title,description:quizList[index].description,maxMarks:quizList[index].maxMarks, numberOfQuestions:quizList[index].numberOfQuestions, active:isActive, category:CategoryData(cid:quizList[index].category?.cid)),provider.id);
                                                          Navigator.pop(context, 'OK');
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),);
                                                }
                                            },textBuilder:(b) => b==QuizActive.NotActive ? Text("Not Active",style: TextStyle(color: Colors.red,fontSize:6.sp),) : Text("Active",style: TextStyle(color: Colors.green,fontSize: 7.sp)) ,borderColorBuilder:(b) => b==QuizActive.NotActive ? Colors.red : Colors.green ,colorBuilder: (b) => b==QuizActive.NotActive ? Colors.red : Colors.greenAccent,current:isActive?QuizActive.Active:QuizActive.NotActive, first: QuizActive.NotActive, second: QuizActive.Active)))
                                  ],
                                );
                              }
                            ),
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


