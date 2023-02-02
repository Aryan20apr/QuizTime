import 'package:quiztime/Admin/Classroom/Students.dart';
import 'package:quiztime/Admin/Classroom/StudentsScreen.dart';
import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:quiztime/Quizzes/Quizes.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/UserListAlbum.dart';
import '../../Api.dart';
import '../../util/Constants.dart';


class Classroom extends StatefulWidget {
  const Classroom({Key? key}) : super(key: key);

  @override
  State<Classroom> createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  late Future <CategoryAlbum> categories;
  //late Future<UserListAlbum> students;
  //late Future <Map<String, dynamic>> quizzes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategoreis();
    // quizzes=getQuizes();
  }

  Future<CategoryAlbum> getCategoreis()async
  {
    API api=API();

    return await api.getAllCategoriesByUser();
    return await api.getAllCategories();
    //quizzes=await api.getAllQuizzes();
  }
  // Future<Map<String,dynamic>> getQuiStudents()async
  // {
  //   API api=API();
  //   return await api.getAllCActiveQuizes();
  //   //quizzes=await api.getAllQuizzes();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      // floatingActionButton: FloatingActionButton(heroTag: "addcategory",child: Icon(Icons.add,color: Colors.white,),onPressed: () {
      //
      //   //UserProvider provider=Provider.of<UserProvider>(context);
      //   Navigator.push(context, MaterialPageRoute(builder: (route)=>CreateCategory()));
      // },
      //
      // ),


      body: /*(Constants.categories.isNotEmpty&&Constants.quizes.isNotEmpty)?CategoryScreenContent():*/FutureBuilder(
          future:Future.wait([categories/*,quizzes*/]),
          builder: (context,snapshot) {
            if(snapshot.hasData)
            {

              // Constants.categories=snapshot.data![0]['data'];
              //Constants.quizes=snapshot.data![1]['data'];
              return CategoryScreenContent(categories: snapshot.data![0],);
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
class CategoryScreenContent extends StatefulWidget {
  CategoryScreenContent({Key? key,required this.categories}) : super(key: key);
  CategoryAlbum categories;
  @override
  State<CategoryScreenContent> createState() => _CategoryScreenContentState();
}

class _CategoryScreenContentState extends State<CategoryScreenContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SingleChildScrollView(

          child: Container(
            height: 100.h-kBottomNavigationBarHeight-10.h,
            width: 100.w,
            child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: widget.categories.data!.length,itemBuilder: ( context, int index)
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
                      colors: [

                        Colors.orangeAccent,
                        Colors.greenAccent,

                      ],
                    ),borderRadius: BorderRadius.circular(20),border: Border.all(width: 2,color: Colors.blueAccent)),
                    height: 10.h,
                    width: 90.w,
                    child:Material(
                      color: Colors.white.withOpacity(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        borderRadius:BorderRadius.circular(20) ,
                        onTap: ()
                        {
                          UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                          Navigator.push(context, MaterialPageRoute(builder: (route)=>StudentsDetails(categoryData: widget.categories.data![index])));
                        },
                        splashFactory: InkRipple.splashFactory,
                        enableFeedback: false,
                        excludeFromSemantics: false,
                        splashColor: Colors.white38,
                        focusColor: Colors.grey.shade300,
                        //highlightColor: Colors.grey.shade300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("${widget.categories.data![index].title}",style: GoogleFonts.alegreyaSc(
                                color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),



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
    );
  }
}

