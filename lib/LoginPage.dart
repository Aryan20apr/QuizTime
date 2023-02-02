import 'package:quiztime/Albums/LoginFailAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/EmailVerification.dart';
import 'package:quiztime/ForgotPassword/ForgotPassword.dart';
import 'package:quiztime/home/NavPage.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:quiztime/util/neumorphic_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'Api.dart';
import 'Admin/AdminNavPage.dart';
import 'home/HomeScreen.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Color textFieldColor=Colors.black;
class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  late TextEditingController passwordController;
  void initState()
  {

    emailController = TextEditingController();
    passwordController = TextEditingController();



  }

  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    var brightness=SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode=brightness==Brightness.dark;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(

          height: height,
          width: width,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 3.h,vertical: 2.h),
            child: Form(
              key: _formKey,
              child: LayoutBuilder(
                  builder: (context,constraints) {
                    return Column(

                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                              decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                              // constraints: BoxConstraints(maxHeight: constraints.maxHeight*0.8 ),
                              width: constraints.maxWidth*0.95,
                              child:Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: LayoutBuilder(
                                    builder: (context,constraint) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset("assets/Login_Page.jpg"),
                                          SizedBox(height: 3.h,),
                                          Text("Enter your registered email id and password:",style: TextStyle(color: textFieldColor,fontSize: 12.sp),),
                                          SizedBox(height: 2.h,),
                                          Neumorphic(
                                            style: NeumorphicStuffs().getTextFieldStyle(),
                                            child: TextFormField(
                                              
                                              style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                              validator: (value) {
                                                String pattern =
                                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                RegExp regex = new RegExp(pattern);
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    !regex.hasMatch(value)) {
                                                  return 'Please enter a valid email';
                                                }
                                                return null;
                                              },
                                              controller: emailController,
                                              keyboardType: TextInputType.emailAddress,
                                              maxLines: 1,
                                              /*decoration: TextFieldDecor(
                                    text: 'Email',
                                    iconInfo: Icons.mail_outline_outlined)
                                    .addTextDecorWithIcon(),*/
                                              decoration: InputDecoration(
                                                  prefixIcon:Icon(Icons.mail_outline_outlined, color: textFieldColor,),
                                                  hintText: 'Email*',
                                                  hintStyle: TextStyle(color: textFieldColor,fontSize: 12.sp)
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: constraint.maxHeight*0.01),
                                          Neumorphic(
                                            style: NeumorphicStuffs().getTextFieldStyle(),
                                            child: TextFormField(
                                              style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                              validator: (value) {
                                                String pattern =
                                                    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
                                                RegExp regex = new RegExp(pattern);
                                                if (value == null ||
                                                    value.isEmpty ||
                                                    !regex.hasMatch(value)) {
                                                  return 'Please enter a valid password';
                                                }
                                                return null;
                                              },
                                              controller: passwordController,
                                              keyboardType: TextInputType.emailAddress,
                                              maxLines: 1,
                                              /*decoration: TextFieldDecor(
                                    text: 'Email',
                                    iconInfo: Icons.mail_outline_outlined)
                                    .addTextDecorWithIcon(),*/
                                              decoration: InputDecoration(
                                                  prefixIcon:Icon(Icons.password_outlined, color:textFieldColor,),
                                                  hintText: 'Password*',
                                                  hintStyle: TextStyle(color: textFieldColor,fontSize: 12.sp)
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: NeumorphicStuffs().getImportantButton(
                                                  text: 'Login',
                                                  ontapped: () async {
                                                    if (_formKey.currentState!
                                                        .validate() /*&& isChecked!*/) {
                                                      API api=API();
                                                  //Map<String ,dynamic> response=   await  api.login( emailController.text,  passwordController.text);
                                                  var user=await api.login(emailController.text, passwordController.text);
                                                      if(user.success==true/*response["success"]*/)
                                                    {

                                                      SharedPreferences preferences=await SharedPreferences.getInstance();
                                                      preferences.setString(Constants.TOKEN, "${user.token}"/*"${response[Constants.TOKEN]}"*/);

                                                      //Map<String,dynamic> userDetails=response['data'];
                                                      UserData? userData=user.data;
                                                      await preferences.setString(Constants.UserId, "${userData?.id/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.EMAIL, "${userData?.email/*userDetails['email']*/}");
                                                      await preferences.setString(Constants.USERNAME,'${userData?.nickname}');
                                                      await preferences.setBool(Constants.LOGIN_STATUS,true);

                                                      UserProvider provider=Provider.of<UserProvider>(context,listen: false);

                                                      provider.username=userData!.nickname!;/*userDetails['nickname'];*/
                                                      provider.email=userData!.email!;
                                                      provider.firstname=userData!.firstName!;
                                                      provider.lastname=userData!.lastName!;
                                                      provider.phoneNumber=userData!.phone!;
                                                      provider.id=userData!.id!;
                                                      provider.token=user.token!;

                                                    //List<dynamic> roleInfo=userDetails['userRoles'];
                                                      List<UserRoles> userRoles=userData!.userRoles!;

                                                      await preferences.setInt(Constants.roleId, userRoles[0]!.role!.roleId!);

                                                      provider.userRoleId=userRoles[0].userRoleId!;
                                                      provider.roleId=userRoles[0].role!.roleId!;
                                                      provider.roleName=userRoles[0].role!.roleName!;
                                                      provider.enabled=userData!.enabled!;

                                                      provider.isloading=LoadingStatus.notLoading;
                                                      provider.isInitialized=true;
                                                     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>NavPage()),);
                                                      if(userRoles[0].role!.roleId==45) {
                                                        print('userRoleId');
                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>StudentNavPage()), (route) => false);
                                                      } else if(userRoles[0].role!.roleId==44) {
                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>AdminNavPage()), (route) => false);
                                                      }


                                                    }
                                                  else {
                                                    LoginFail loginFail=user;
                                                    Fluttertoast.showToast(msg:loginFail!.message! );
                                                  }
                                                    }
                                                  }

                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              )
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New user?',
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EmailVerification()));
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: isDarkMode?Colors.white:Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: isDarkMode?Colors.white:Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ForgotPassword()));
                                    },
                                    child: Text(
                                      'Reset Password',
                                      style: TextStyle(
                                          color: isDarkMode?Colors.white:Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }

}
