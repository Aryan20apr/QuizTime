import 'package:quiztime/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/QuestionAlbum.dart';
import '../../Albums/QuizAlbum.dart';
import 'CreateQuestion.dart';
import 'UpdateQuestion.dart';
class QuestionsList extends StatefulWidget {
   QuestionsList({Key? key,required this.quiz}) : super(key: key);
  QuizData quiz;
  @override
  State<QuestionsList> createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
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
    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(heroTag: "Add Question",child: Icon(Icons.add,color: Colors.white,),onPressed: () {

        //UserProvider provider=Provider.of<UserProvider>(context);
        Navigator.push(context, MaterialPageRoute(builder: (route)=>CreateQuestion(quiz:widget.quiz)));
      },

      ),
      appBar: AppBar( backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Questions',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
  List<List<Color>> colorListAdmin=[[Colors.yellow,Colors.deepOrange],[Colors.lightGreenAccent,Colors.lightGreenAccent.shade700,]];
  @override
  Widget build(BuildContext context) {

    return SmartRefresher(  enablePullDown: true,
      //enablePullUp: true,
      onRefresh: _onRefresh,
      // onLoading: _onLoading,
      header: WaterDropMaterialHeader(color:Colors.blueAccent,backgroundColor: Colors.white,),
      controller: _refreshController,
       child: Container(
         color: Theme.of(context).scaffoldBackgroundColor,
         height:100.h,
         width:100.w,
         child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: widget.questionAlbum.data!.length, itemBuilder: (BuildContext context, int index) {
           List<QuestionData> questions=widget.questionAlbum.data!;
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Neumorphic(
               style:  NeumorphicStyle( intensity: 50,shape: NeumorphicShape.convex,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),),
               child: Container(
                   decoration:BoxDecoration(gradient: LinearGradient(
                     begin: Alignment.topRight,
                     end: Alignment.bottomLeft,
                     colors: colorListAdmin[1],
                   ),borderRadius: BorderRadius.circular(10),/*border: Border.all(width: 2,color: Colors.black)*/),
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Text('${questions[index].content}',style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 15.sp),),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children:<Widget>[
                     Text('A. ${questions[index].option1}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                     Text('B. ${questions[index].option2}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                   ]),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children:<Widget>[
                         Text('C. ${questions[index].option2}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                         Text('D. ${questions[index].option3}',style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,fontSize: 12.sp),),
                       ]),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top:8.0,left: 8.0),
                         child: Align(alignment: Alignment.centerLeft,child: Text('Answer:${questions[index].answer}',style: TextStyle(color: Theme.of(context).textTheme.headlineMedium!.color,fontSize: 13.sp),)),

                       ),
                       Row(
                         children: [
                           IconButton(onPressed: (){
                             Navigator.push(context,MaterialPageRoute(builder: (route)=>UpdateQuestion(quiz: widget.quiz,question:questions[index] ,))).then((value) {
                               _onRefresh();
                             });
                           }, icon: Icon(FontAwesomeIcons.pen,color: Colors.red,)),
                           IconButton(onPressed: (){
                             showDialog<void>(
                               context: context,
                               barrierDismissible: false, // user must tap button!
                               builder: (BuildContext context) {
                                 return AlertDialog(
                                   title: const Text('Delete Question'),
                                   content: SingleChildScrollView(
                                     child: Text('Do yoy want to delete this question ? This operation cannot be reversed.'),
                                   ),
                                   actions: <Widget>[
                                     TextButton(
                                       child: const Text('Cancel'),
                                       onPressed: () {
                                         Navigator.of(context).pop();
                                       },
                                     ),
                                     TextButton(
                                       child: const Text('Delete'),
                                       onPressed: ()async {
                                         Map<String,dynamic> response=await api.deleteQuestions(questions[index].qid!);
                                         if(response['success'])
                                         {Navigator.of(context).pop();
                                           Fluttertoast.showToast(msg:'Question Deleted Successfully');
                                         }
                                         else
                                           {
                                             Fluttertoast.showToast(msg:"Could not delete question");
                                           }
                                       },
                                     ),
                                   ],
                                 );
                               },
                             );
                           }, icon: Icon(FontAwesomeIcons.trash,color: Colors.red,)),
                         ],
                       ),
                     ],
                   ),
                 ],),
               )
         ),
             ),
           ); },),
       ),
    );

  }
}
