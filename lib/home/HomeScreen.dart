import 'package:quiztime/Student/Enrollment/AllSubjects.dart';
import 'package:quiztime/home/AllCategories.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:quiztime/Api.dart';

import '../util/Constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 /* late Future<Map<String, dynamic>> categories;
  late Future<Map<String, dynamic>> quizzes;
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   /* categories = getCategoreis();
    quizzes = getQuizes();*/
  }

  /*Future<Map<String, dynamic>> getCategoreis() async {
    API api = API();
    return await api.getAllCategories();
    //quizzes=await api.getAllQuizzes();
  }

  Future<Map<String, dynamic>> getQuizes() async {
    API api = API();
    return await api.getAllCActiveQuizes();
    //quizzes=await api.getAllQuizzes();
  }*/

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(), child: HomeScreenContent())));
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {

  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    UserProvider provider = Provider.of<UserProvider>(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text(
              'Welcome ${provider.firstname},',
              style: GoogleFonts.akayaKanadaka(
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,),textAlign: TextAlign.start,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: isDarkMode?LinearGradient( begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.black, Colors.black, Colors.black], ):LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.green.shade100, Colors.green.shade100, Colors.green.shade100],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 4, color: isDarkMode?Colors.blue:Colors.black)),
                  height: 20.h,
                  width: 40.w,
                  child: Material(
                    color: Colors.white.withOpacity(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                        Navigator.push(context, MaterialPageRoute(builder: (route)=>NewCategories( userid: provider.id,)));
                      },
                      splashFactory: InkRipple.splashFactory,
                      enableFeedback: false,
                      excludeFromSemantics: false,
                      splashColor: Colors.white38,
                      focusColor: Colors.grey.shade300,
                      //highlightColor: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Enroll in new course",style: GoogleFonts.laila

                            (
    color: Theme.of(context).textTheme.headlineLarge?.color, fontSize: 12.sp),textAlign: TextAlign.center,),
                          Icon(FontAwesomeIcons.school,color: Theme.of(context).textTheme.headlineLarge?.color)

                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: isDarkMode?LinearGradient( begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.black, Colors.black, Colors.black], ):LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.green.shade100, Colors.green.shade100, Colors.green.shade100] ,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 4, color:  isDarkMode?Colors.blue:Colors.black)),
                  height: 20.h,
                  width: 40.w,
                  child: Material(
                    color: Colors.white.withOpacity(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                        //Navigator.push(context, MaterialPageRoute(builder: (route)=>AdminQuizes(category:widget.categories.data![index], userId: provider.id,)));
                      },
                      splashFactory: InkRipple.splashFactory,
                      enableFeedback: false,
                      excludeFromSemantics: false,
                      splashColor: Colors.white38,
                      focusColor: Colors.grey.shade300,
                      //highlightColor: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("Join your teacher's classroom",style: GoogleFonts.laila(
                              color: Theme.of(context).textTheme.headlineLarge?.color, fontSize: 12.sp,),textAlign: TextAlign.center,),
                          ),
                          Icon(Icons.class_,color: Theme.of(context).textTheme.headlineLarge?.color)
                          /*Text("${widget.categories.data![index].title}",style: GoogleFonts.alegreyaSc(
    color: Colors.white, fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    Text("${widget.categories.data![index].description}",style: GoogleFonts.laila(
    color: Colors.black, fontSize: 12.sp,),textAlign: TextAlign.center,),*/
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

/*
class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
        */
/*  Container(
            width: 100.w,
            height: 10.h,
            decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("All That Quizz",style: GoogleFonts.akayaKanadaka(color: Colors.white,fontSize: 25.sp),),
              )),*/ /*

          HomeItem(option: "Categories",onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (route)=>CategoriesScreen()));
          },),
          Container(
            height: 15.h,
            width: 98.w,
            decoration:BoxDecoration(color: Colors.blue.shade50,borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: Constants.categories.length,scrollDirection:Axis.horizontal,itemBuilder: (BuildContext context, int index) {

              return CategoryItem(category:Constants.categories[index]);
            },


            ),
          ),

          HomeItem(option: "All Quizzes",onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (route)=>AccountSettings()));
          },),
          Container(
            height: 13.h,
            width: 98.w,
            decoration:BoxDecoration(color: Colors.purple.shade50,borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: Constants.quizes.length,scrollDirection:Axis.horizontal,itemBuilder: (BuildContext context, int index) {

              return QuizItem(quiz: Constants.quizes[index]);
            },


            ),
          ),
          HomeItem(option: "Attempted Quizzes",onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (route)=>AccountSettings()));
          },),

        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
   CategoryItem({
    super.key,required this.category
  });

  Map<String,dynamic> category;
  @override
  Widget build(BuildContext context) {
    return
           Padding(
            padding: const EdgeInsets.all(4.0),
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.grey.shade300,
                focusColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade300,
                //overlayColor: ,
                enableFeedback: false,
                excludeFromSemantics: false,
                onTap: () {},
                child: Container(
                  height: 12.h,
                  width: 30.w,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text("${category['title']}", style: GoogleFonts.alegreyaSc(
                                color: Colors.black, fontSize: 10.sp),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Align(alignment: Alignment.bottomRight, child: Icon(
                          Icons.open_in_new, color: Colors.black,))
                      ],
                    ),
                  ),
                ),
              ),
            ),




    );
  }
}
class QuizItem extends StatelessWidget {
  QuizItem({
    super.key,required this.quiz
  });

  Map<String,dynamic> quiz;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.grey.shade300,
            focusColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade300,
            //overlayColor: ,
            enableFeedback: false,
            excludeFromSemantics: false,
            onTap: () {},
            child: Container(
              height: 11.h,
              width: 40.w,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text("${quiz['title']}", style: GoogleFonts.alegreyaSc(
                            color: Colors.black, fontSize: 10.sp),
                          textAlign: TextAlign.center,),
                      ),
                    ),
                    Align(alignment: Alignment.bottomRight, child: Icon(
                      Icons.arrow_circle_right, color: Colors.black,))
                  ],
                ),
              ),
            ),
          ),
        ),




      );
  }
}
class HomeItem extends StatelessWidget {
  HomeItem({
    super.key,required this.option, this.onTap
  });

  String option;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border(),*/
/*color: Colors.green.shade50*/ /*
),
        height:8.h,
        width:90.h,
        child: Align(
          alignment: Alignment.center,
          child: ListTile(

            style: ListTileStyle.list,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: onTap,
            enableFeedback: true,
            focusColor: Colors.grey,
           // leading: Icon(icon,color: Colors.black,),
            title: Text(option,style: GoogleFonts.lato(color: Colors.black),),
            trailing: Icon(Icons.arrow_forward_rounded,color: Colors.black,),
          ),
        ),
      ),
    );
  }
}
*/
