import 'package:quiztime/Api.dart';
import 'package:quiztime/LoginPage.dart';
import 'package:quiztime/Admin/AdminNavPage.dart';
import 'package:quiztime/home/NavPage.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:quiztime/util/Themes.dart';
import 'package:quiztime/util/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'Registration.dart';
import 'package:provider/provider.dart';


late SharedPreferences preferences;
bool loggedIn=false;
int? roleId=45;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  preferences=await SharedPreferences.getInstance();

  if(preferences.containsKey(Constants.LOGIN_STATUS)&&preferences.getBool(Constants.LOGIN_STATUS)==true)
  {
    loggedIn=true;
    roleId=preferences.getInt(Constants.roleId);
   /* Future.wait(
     [  API().getAllCategories()]
    ).then((value) => {
      //Constants.categories=value[0]
    });*/
  }
  runApp(const MyApp());
  /*if(preferences.containsKey(Constants.TOKEN)&&preferences.getString(Constants.TOKEN)?.length!=0)
    {
      user=await API().getUser(preferences.getString(Constants.EMAIL),preferences.getString(Constants.TOKEN));
    }*/

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if(user.isNotEmpty)
    //   {
    //     UserProvider provider=Provider.of<UserProvider>(context,listen: false);
    //     Map<String,dynamic> userDetails=user['data'];
    //     provider.username=userDetails['username'];
    //     provider.email=userDetails['email'];
    //     provider.firstname=userDetails['firstName'];
    //     provider.lastname=userDetails['lastName'];
    //     provider.phoneNumber=userDetails['phone'];
    //     provider.id=userDetails['id'];
    //     provider.token=user[Constants.TOKEN];
    //
    //     List<dynamic> roleInfo=userDetails['userRoles'];
    //     provider.userRoleId=roleInfo[0]['userRoleId'];
    //     provider.roleId=roleInfo[0]['role']['roleId'];
    //     provider.roleName=roleInfo[0]['role']['roleName'];
    //     provider.enabled=userDetails['enabled'];
    //   }
    return Sizer(builder: (context, orientation, deviceType) {

      return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LIGHT_THEME_DATA,
            darkTheme: DARK_THEME_DATA,
            home: loggedIn?roleId==Constants.student?StudentNavPage():AdminNavPage():WelcomeScreen(),
      ));
    });
  }
}
