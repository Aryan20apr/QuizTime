import 'package:quiztime/Admin/Category/AdminCategoryScreen.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/Api.dart';
import 'package:quiztime/Admin/AdminHomeScreen.dart';
import 'package:quiztime/home/HomeScreen.dart';
import 'package:quiztime/home/AllCategories.dart';
import 'package:quiztime/main.dart';
import 'package:quiztime/settings/SettingsScreen.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sizer/sizer.dart';
import '../LoginPage.dart';
import '../provider/user_provider.dart';
import '../home/History.dart';
import 'Classroom/Classroom.dart';
class AdminNavPage extends StatefulWidget {
  const AdminNavPage({Key? key}) : super(key: key);

  @override
  State<AdminNavPage> createState() => _AdminNavPageState();
}

class _AdminNavPageState extends State<AdminNavPage> {

  List<String> title= [
    //"All That Quizz Admin",
    "Your Quizzes",
    "Your Classroom",
    "Settings"
  ];

  int currentTab = 0;
  List<Widget> screens = [];
  late SharedPreferences preferences;
  late UserProvider provider;
  //late Future <Map<String,dynamic>> user;
  late Future <UserAlbum> user;
  late Future <Map<String,dynamic>> user2;
  @override
  void initState() {
    super.initState();
    user= getUser();

    //Widget home = AdminHome();
    Widget categories = AdminCategories();
    Widget classroom = Classroom();
    Widget profile = Settings();
    currentScreen = AdminHome();
    screens = [/*home,*/ classroom,categories , profile];
    currentScreen = screens[0];
  }
  Future<UserAlbum> getUser()async
  {
    preferences=await SharedPreferences.getInstance();
    return await API().getUser(preferences.getString(Constants.EMAIL), preferences.getString(Constants.TOKEN));

    //provider.updateLoadingStatus(LoadingStatus.notLoading);

  }

  /*void setData()
    { Map<String,dynamic> userDetails=user['data'];
      provider.username=userDetails['nickname'];
      provider.email=userDetails['email'];
      provider.firstname=userDetails['firstName'];
      provider.lastname=userDetails['lastName'];
      provider.phoneNumber=userDetails['phone'];
      provider.id=userDetails['id'];
    List<dynamic> roleInfo=userDetails['userRoles'];
    provider.userRoleId=roleInfo[0]['userRoleId'];
    provider.roleId=roleInfo[0]['role']['roleId'];
    provider.roleName=roleInfo[0]['role']['roleName'];
    provider.enabled=userDetails['enabled'];
    provider.updateInitialization();
    }*/
  final pageStorageBucket = PageStorageBucket();
  late Widget currentScreen;
  @override
  Widget build(BuildContext context) {

    provider=Provider.of<UserProvider>(context,listen: false);
    /*if(provider.isloading==LoadingStatus.notLoading&&provider.isInitialized==false)
      {
       setData();
      }*/

    return SafeArea(
      child: Scaffold(

        // drawer: Drawer(
        //   backgroundColor: Colors.white,
        //   child:ListView(
        //     children: [
        //      //UserAccountsDrawerHeader(accountName: Text('${preferences.getString(Constants.USERNAME)}'), accountEmail: Text("${preferences.getString(Constants.EMAIL)}")),
        //       ListTile(
        //         iconColor: Colors.black,
        //         textColor: Colors.black,
        //         onTap: ()async{
        //           SharedPreferences preferences=await SharedPreferences.getInstance();
        //           preferences.setBool(Constants.LOGIN_STATUS,false);
        //           provider.isloading=LoadingStatus.loading;
        //           provider.isInitialized=false;
        //           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>LoginPage()), (route) => false);
        //         },
        //         leading: Icon(Icons.logout_rounded),
        //         title: Text("Logout",style: TextStyle(fontSize: 15.sp),),
        //       )
        //     ],
        //   ),

        // ),
        appBar: AppBar(
          // backgroundColor: Colors.green,
          title: Text(title[currentTab],
            style: GoogleFonts.laila(textStyle: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor)),),
        ),
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: user,
            builder: (context,snapshot) {
             // print("Snapshot has data ${snapshot.hasData} ${snapshot.data!.success}");
              if (snapshot.hasData) {
                  print("Snapshot has data");
                UserAlbum userAlbum=snapshot.data!;
                UserData? userData=userAlbum.data!;
                // Map<String,dynamic> userDetails=snapshot.data!['data'];
                // provider.username=userDetails['nickname'];
                // provider.email=userDetails['email'];
                // provider.firstname=userDetails['firstName'];
                // provider.lastname=userDetails['lastName'];
                // provider.phoneNumber=userDetails['phone'];
                // provider.id=userDetails['id'];
                // List<dynamic> roleInfo=userDetails['userRoles'];
                // provider.userRoleId=roleInfo[0]['userRoleId'];
                // provider.roleId=roleInfo[0]['role']['roleId'];
                // provider.roleName=roleInfo[0]['role']['roleName'];
                // provider.enabled=userDetails['enabled'];
                // provider.isInitialized=true;
                provider.username=userData!.nickname!;/*userDetails['nickname'];*/
                provider.email=userData!.email!;
                provider.firstname=userData!.firstName!;
                provider.lastname=userData!.lastName!;
                provider.phoneNumber=userData!.phone!;
                provider.id=userData!.id!;
                //provider.token=userAlbum.token!;

                //List<dynamic> roleInfo=userDetails['userRoles'];
                List<UserRoles> userRoles=userData!.userRoles!;
                provider.userRoleId=userRoles[0].userRoleId!;
                provider.roleId=userRoles[0].role!.roleId!;
                provider.roleName=userRoles[0].role!.roleName!;
                provider.enabled=userData!.enabled!;

                provider.isloading=LoadingStatus.notLoading;
                provider.isInitialized=true;
                return PageStorage(
                  bucket: pageStorageBucket,
                  child:  currentScreen,
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
              }}),

        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     Icons.change_circle_sharp,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation
        //     .centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).bottomAppBarTheme.color,
          elevation: 100,
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // MaterialButton(
                      //   minWidth: 40,
                      //   onPressed: () {
                      //     setState(() {
                      //       currentScreen = screens[0];
                      //       currentTab = 0;
                      //     });
                      //   },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         FontAwesomeIcons.house,
                      //         color: currentTab == 0
                      //             ? Theme
                      //             .of(context)
                      //             .iconTheme.color
                      //             : Colors.grey,
                      //       ),
                      //       Text(
                      //         'Home',
                      //         style: TextStyle(
                      //             color: currentTab == 0
                      //                 ? Theme
                      //                 .of(context)
                      //                 .iconTheme.color
                      //                 : Colors.grey),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // MaterialButton(
                      //   minWidth: 40,
                      //   onPressed: () {
                      //     setState(() {
                      //       currentScreen = screens[1];
                      //       currentTab = 1;
                      //     });
                      //   },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         FontAwesomeIcons.question,
                      //         color: currentTab == 1
                      //             ? Theme
                      //             .of(context)
                      //             .iconTheme.color
                      //             : Colors.grey,
                      //       ),
                      //       Text(
                      //         'Your Quizzes',
                      //         style: TextStyle(
                      //             color: currentTab == 1
                      //                 ? Theme
                      //                 .of(context)
                      //                 .iconTheme.color
                      //                 : Colors.grey),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),*/
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[0];
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.class_rounded,
                              color: currentTab == 0
                                  ?  Theme
                                  .of(context)
                                  .iconTheme.color
                                  : Colors.grey,
                            ),
                            Text(
                              'Classroom',
                              style: TextStyle(
                                  color: currentTab == 0
                                      ?  Theme
                                      .of(context)
                                      .iconTheme.color
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[1];
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.question,
                              color: currentTab == 1
                                  ? Theme
                                  .of(context)
                                  .iconTheme.color
                                  : Colors.grey,
                            ),
                            Text(
                              'Your Quizzes',
                              style: TextStyle(
                                  color: currentTab == 1
                                      ? Theme
                                      .of(context)
                                      .iconTheme.color
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[2];
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: currentTab == 2
                                  ?  Theme
                                  .of(context)
                                  .iconTheme.color
                                  : Colors.grey,
                            ),
                            Text(
                              'Settengs',
                              style: TextStyle(
                                  color: currentTab == 2
                                      ?  Theme
                                      .of(context)
                                      .iconTheme.color
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );





  }
}
