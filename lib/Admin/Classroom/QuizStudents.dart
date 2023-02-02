import 'package:quiztime/Albums/AdminHistoryAlbum.dart';
import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/Albums/UserListAlbum.dart';
import 'package:quiztime/util/neumorphic_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../Api.dart';
import '../../provider/user_provider.dart';
import '../../util/colors.dart';

class QuizStudents extends StatefulWidget {
  QuizStudents({Key? key, required this.quizid}) : super(key: key);
  int? quizid;
  @override
  State<QuizStudents> createState() => _QuizStudentsState();
}

class _QuizStudentsState extends State<QuizStudents> {
  late Future<AdminHistoryAlbum> history;
  //late Future<UserListAlbum> students;
  //late Future <Map<String, dynamic>> quizzes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    history = getStudent();
    // quizzes=getQuizes();
  }

  Future<AdminHistoryAlbum> getStudent() async {
    API api = API();

    return await api.quizHistoryAdmin(widget.quizid!);
    //return await api.getAllCategories();
    //quizzes=await api.getAllQuizzes();
  }

  // Future<Map<String,dynamic>> getQuiQuizStudents()async
  // {
  //   API api=API();
  //   return await api.getAllCActiveQuizes();
  //   //quizzes=await api.getAllQuizzes();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(heroTag: "addcategory",child: Icon(Icons.add,color: Colors.white,),onPressed: () {
          //
          //   //UserProvider provider=Provider.of<UserProvider>(context);
          //   Navigator.push(context, MaterialPageRoute(builder: (route)=>CreateCategory()));
          // },
          //
          // ),

          appBar: AppBar(
            titleSpacing: 0.0,
            foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              'Your Class Performance ',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).appBarTheme.foregroundColor),
            ),
          ),
          body: /*(Constants.categories.isNotEmpty&&Constants.quizes.isNotEmpty)?QuizStudentsContent():*/
          FutureBuilder(
              future: Future.wait([history]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Constants.categories=snapshot.data![0]['data'];
                  //Constants.quizes=snapshot.data![1]['data'];
                  return QuizStudentsContent(
                    history: snapshot.data![0],
                    quizid: widget.quizid,
                  );
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
              }),
        ));
  }
}

class QuizStudentsContent extends StatefulWidget {
  QuizStudentsContent({Key? key, required this.quizid,required this.history}) : super(key: key);
  AdminHistoryAlbum history;
  int? quizid;
  @override
  State<QuizStudentsContent> createState() => _QuizStudentsContentState();
}

class _QuizStudentsContentState extends State<QuizStudentsContent> {
  late Future<AdminHistoryAlbum>history;
  API api=API();
  void _onRefresh() async{
    // monitor network fetch

    history=  api.quizHistoryAdmin(widget.quizid!);
    Future.wait([history]).then((value) =>
        setState(()
        {
          widget.history=value[0];}));
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

  @override
  Widget build(BuildContext context) {
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Neumorphic(
                  style: NeumorphicStyle( shape: NeumorphicShape.concave,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0,color: isDarkMode?Colors.white:Colors.black),
                        borderRadius: BorderRadius.circular(20),
                        color: isDarkMode?Colors.white:Colors.purple),
                    child: ListTile(leading:Text('Student Id',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 12.sp),) ,
                        title: Text(
                            'Student Details',style: TextStyle(color: isDarkMode?Colors.black:Colors.white,fontSize: 12.sp)),
                        trailing: Text('Marks',style: TextStyle(color: isDarkMode?Colors.black :Colors.white,fontSize: 12.sp))),
                  ),
                ),
              ),
              Container(
                height: 100.h - kBottomNavigationBarHeight - 10.h,
                width: 100.w,
                child: SmartRefresher(
                  enablePullDown: true,
                  //enablePullUp: true,
                  onRefresh: _onRefresh,
                  // onLoading: _onLoading,
                  header: WaterDropMaterialHeader(color:Colors.blueAccent,backgroundColor: Colors.white,),
                  controller: _refreshController,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.history.data!.length,
                    itemBuilder: (context, int index) {
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
                      AdminHistoryData historyData = widget.history.data![index];
                      //Icon isEnabledIcon=historyData.enabled==true?Icon(Icons.check_circle_rounded,color: Colors.green,):Icon(Icons.cancel,color: Colors.red,);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Neumorphic(
                          style: NeumorphicStyle( shape: NeumorphicShape.concave,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),),
                          child: Container(
                              decoration: BoxDecoration(

                                color: kSelectedAnswer,
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
                                  Navigator.push(context, MaterialPageRoute(builder: (route)=>QuizStudents(categoryData: widget.categories.data![index])));*/
                                    },
                                    splashFactory: InkRipple.splashFactory,
                                    enableFeedback: false,
                                    excludeFromSemantics: false,
                                    splashColor: Colors.white38,
                                    focusColor: Colors.grey.shade300,
                                    //highlightColor: Colors.grey.shade300,
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Text('${historyData.user!.id}',style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color,fontSize: 15.sp),),
                                      title: Text(
                                          '${historyData.user!.firstName} ${historyData.user!.lastName}',style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color,fontSize: 12.sp)),
                                      subtitle: Text(
                                          'Username: ${historyData.user!.nickname}',style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color,fontSize: 12.sp)),
                                      trailing:  Container(decoration: BoxDecoration(shape: BoxShape.circle),child: Text('${historyData.marks}',style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color,fontSize: 15.sp),),)
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
