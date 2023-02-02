import 'package:quiztime/Quizzes/Quizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Albums/CategoryAlbum.dart';
import '../Api.dart';
import '../provider/user_provider.dart';
import '../util/Constants.dart';
import 'HomeScreen.dart';

/*
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future <Map<String, dynamic>> categories;
  late Future <Map<String, dynamic>> quizzes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategoreis();
    quizzes=getQuizes();
  }

  Future<Map<String,dynamic>> getCategoreis()async
  {
    API api=API();
    return await api.getAllCategories();
    //quizzes=await api.getAllQuizzes();
  }
  Future<Map<String,dynamic>> getQuizes()async
  {
    API api=API();
    return await api.getAllCActiveQuizes();
    //quizzes=await api.getAllQuizzes();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      backgroundColor: Colors.white70,
      body: (Constants.categories.isNotEmpty&&Constants.quizes.isNotEmpty)?CategoryScreenContent():FutureBuilder(
          future:Future.wait([categories,quizzes]),
          builder: (context,snapshot) {
            if(snapshot.hasData)
            {

              Constants.categories=snapshot.data![0]['data'];
              Constants.quizes=snapshot.data![1]['data'];
              return CategoryScreenContent();
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
  const CategoryScreenContent({Key? key}) : super(key: key);

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
            child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: Constants.categories.length,itemBuilder: ( context, int index)
              {
               */
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
               );*//*

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration:BoxDecoration(gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.red,
                          Colors.yellow
                        ],
                      ),borderRadius: BorderRadius.circular(20),border: Border.all(width: 2,color: Colors.blueAccent)),
                    height: 20.h,
                    width: 90.w,
                    child:Material(
                      color: Colors.white.withOpacity(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                          borderRadius:BorderRadius.circular(20) ,
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (route)=>Quizes(category:Constants.categories[index])));
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
                            Text("${Constants.categories[index]['title']}",style: GoogleFonts.alegreyaSc(
                                color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            Text("${Constants.categories[index]['description']}",style: GoogleFonts.laila(
                                color: Colors.black, fontSize: 12.sp,),textAlign: TextAlign.center,),


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
*/
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future <CategoryAlbum> categories;
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

    return  await api.getAllCategoriesByEnrolledUser();
    //return await api.getAllCategories();
    //quizzes=await api.getAllQuizzes();
  }
  // Future<Map<String,dynamic>> getQuizes()async
  // {
  //   API api=API();
  //   return await api.getAllCActiveQuizes();
  //   //quizzes=await api.getAllQuizzes();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(


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
                        Colors.orange,
                        Colors.red,
                        Colors.yellow
                      ],
                    ),borderRadius: BorderRadius.circular(20),border: Border.all(width: 2,color: Colors.blueAccent)),
                    height: 20.h,
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
                          Navigator.push(context, MaterialPageRoute(builder: (route)=>Quizes(category:widget.categories.data![index], userid: provider.id,)));
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
                            Text("${widget.categories.data![index].description}",style: GoogleFonts.laila(
                              color: Colors.black, fontSize: 12.sp,),textAlign: TextAlign.center,),


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


