import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Api.dart';


//late Future <Map<String, dynamic>> quizzes;

class NewCategories extends StatefulWidget {
  NewCategories({Key? key,required this.userid}) : super(key: key);
  
  int userid;
  @override
  State<NewCategories> createState() => _NewCategoriesState();
}

class _NewCategoriesState extends State<NewCategories> {
  late Future<CategoryAlbum>futurecategories;

  // late CategoryData category;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //category=CategoryData.fromJson(widget.category);
    //quizzes=getNewCategories();
    futurecategories=getNewCategories(widget.userid);
  }


  Future<CategoryAlbum> getNewCategories(int userid)async
  {
    API api=API();
 
      return  api.getAllCategoriesnotenrolled();
    //quizzes=await api.getAllQuizzes();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text('New Courses',style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
          future:Future.wait([/*quizzes*/futurecategories]),
          builder: (context,snapshot) {
            if(snapshot.hasData)
            {

              CategoryAlbum categoryAlbum=snapshot.data![0];
              //Constants.quizes=snapshot.data![0]['data'];
              return NewCategoriesList(categories:categoryAlbum);
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
class NewCategoriesList extends StatefulWidget {
  NewCategoriesList({Key? key,required this.categories}) : super(key: key);
  CategoryAlbum categories;

  @override
  State<NewCategoriesList> createState() => _NewCategoriesListState();
}

class _NewCategoriesListState extends State<NewCategoriesList> {
  late Future<CategoryAlbum >categories;

  API api=API();
  void _onRefresh() async{
    // monitor network fetch

    categories=  api.getAllCategories();
    Future.wait([categories]).then((value) =>
        setState(()
        {
          widget.categories=value[0];}));
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
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
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
              child: ListView.builder(physics: BouncingScrollPhysics(),itemCount:widget.categories.data!.length ,itemBuilder: ( context, int index)
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
                CategoryData categoryData=widget.categories.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle( shape: NeumorphicShape.concave,boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),),
                    child: Container(
                        decoration: BoxDecoration(

                          color: isDarkMode?Colors.white:Colors.white
                          ,
                          /*gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                    ],
                                  ),*/
                          borderRadius: BorderRadius.circular(10),
                          /* border:
                                      Border.all(width: 2, color: Colors.blueAccent)*/),
                        height: 10.h,
                        width: 90.w,
                        child: Material(
                          color: Colors.white.withOpacity(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(10),
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
                                leading: Text('${categoryData.cid}',style: TextStyle(/*color: Theme.of(context).textTheme.displayMedium?.color,*/fontSize: 15.sp),),
                                title: Text(
                                    '${categoryData.title} ',style: TextStyle(color: Colors.black),),
                                subtitle: Text(
                                    ' ${categoryData.description}'),
                                 trailing: IconButton(icon: Icon(Icons.add_task), onPressed: () {
                                   showModalBottomSheet(context: context, builder: (context){
                                     return Container(height: 30.h, decoration: BoxDecoration(

                                     color: Theme.of(context).scaffoldBackgroundColor,
                                     /*gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.black,
                                      Colors.black12,
                                    ],
                                  ),*/
                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                                     child: Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                                       child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [Text(
                                           'Do you wish to enroll in ${categoryData.title} course ?',style: TextStyle(color: Theme.of(context).textTheme.displayMedium?.color,fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                                         ,
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: <Widget>[
                                             TextButton(onPressed: (){
                                               Navigator.pop(context);
                                             }, child: Text("Cancel",style: TextStyle(fontSize: 12.sp))),
                                             TextButton(onPressed: ()async{
                                               UserProvider provider=Provider.of<UserProvider>(context,listen: false);
                                               CategoryAlbum responde=await API().enrollInSubject(provider.id, categoryData.cid!);
                                               if(responde.success==true)
                                                 Navigator.pop(context);
                                             }, child: Text("Enroll",style: TextStyle(fontSize: 12.sp)))
                                           ],
                                         )
                                       ],),
                                     ),);
                                   });
                                 },),
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
        ),
      ),
    );
  }
}


