import 'package:quiztime/Api.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:quiztime/util/colors.dart';
import 'package:quiztime/util/neumorphic_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'Albums/UserAlbum.dart';
import 'LoginPage.dart';
import 'home/NavPage.dart';


class RegistrationPage extends StatefulWidget {
   RegistrationPage({Key? key,required this.email}) : super(key: key);
  String email;
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
Color textFieldColor=Colors.black;
class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController phoneNumberController;
  late TextEditingController passwordController;
  AccountType? _accountType=null;
  void initState()
  {
    phoneNumberController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    
    emailController.text=widget.email;
  }
  @override
  Widget build(BuildContext context) {
    
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

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
                            flex: 9,
                            child: Container(
                                decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                            // constraints: BoxConstraints(maxHeight: constraints.maxHeight*0.8 ),
                             width: constraints.maxWidth*0.95,
                             child:Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: LayoutBuilder(
                                 builder: (context,constraint) {
                                   return Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Neumorphic( style:NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a valid username name';
                                             }
                                             return null;
                                           },
                                           controller: usernameController,
                                           keyboardType: TextInputType.name,
                                           maxLines: 1,
                                           decoration: InputDecoration(
                                               prefixIcon:Icon(Icons.account_circle_outlined,color: textFieldColor,),
                                               hintText: 'Username*',
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                       Neumorphic( style:NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a valid first name';
                                             }
                                             return null;
                                           },
                                           controller: firstNameController,
                                           keyboardType: TextInputType.name,
                                           maxLines: 1,
                                           decoration: InputDecoration(
                                               prefixIcon:Icon(Icons.account_circle_outlined,color: textFieldColor,),
                                               hintText: 'First Name*',
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                       Neumorphic( style:NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                           validator: (value) {
                                             if (value == null || value.isEmpty) {
                                               return 'Please enter a valid last name';
                                             }
                                             return null;
                                           },
                                           controller: lastNameController,
                                           keyboardType: TextInputType.name,
                                           maxLines: 1,
                                           decoration: InputDecoration(
                                               prefixIcon:Icon(Icons.account_circle_outlined,color: textFieldColor,),
                                               hintText: 'Last Name*',
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                        Neumorphic(
                                         style: NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           readOnly: true,
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
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
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),
                                       ),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                       Neumorphic(
                                         style: NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                                           obscureText: true,
                                           style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
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
                                               hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp)
                                           ),
                                         ),
                                       ),
                                       SizedBox(height: constraint.maxHeight*0.01),
                                       Neumorphic(
                                         style: NeumorphicStuffs().getTextFieldStyle(),
                                         child: TextFormField(
                      style: TextStyle(color: textFieldColor,fontWeight: FontWeight.normal,fontSize: 10.sp),
                                           validator: (value) {
                                             String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                             RegExp regExp = new RegExp(patttern);
                                             if (value == null ||
                                                 value.isEmpty ||
                                                 value.length != 10 ||
                                                 !regExp.hasMatch(value)) {
                                               return 'Please enter a valid phone number';
                                             }
                                             return null;
                                           },
                                           controller: phoneNumberController,
                                           keyboardType: TextInputType.number,
                                           maxLines: 1,
                                           /* decoration: TextFieldDecor(text: 'Mobile Number',
                                    iconInfo: Icons.phone)
                                    .addTextDecorWithIcon(),*/
                                           decoration: InputDecoration(
                                               hintText: 'Mobile Number*',
                      hintStyle: TextStyle(color: textFieldColor,fontSize: 10.sp),
                                               prefixIcon:  Padding(
                                                 padding: EdgeInsets.only(top:13.0),
                                                 child: Text(
                                                   '(+91)',
                                                   textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 10.sp,
                                                     color: textFieldColor,),
                                                 ),
                                               ),
                                               prefixIconColor: textFieldColor
                                             //prefixText: '(+91)   ',
                                             //prefixStyle: TextStyle(color: textFieldColor,fontWeight: FontWeight.bold)
                                             /*  prefix: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        '(+91)',
                                        style: TextStyle(color: textFieldColor),
                                      ),
                                    ),*/
                                           ),
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Text("Choose Account type:",style: TextStyle(color: Colors.black),),
                                       ),
                                       Row(

                                         crossAxisAlignment: CrossAxisAlignment.center,

                                         children: <Widget>[
                                           Container(
                                             height:constraint.maxHeight*0.1,
                                             width:constraint.maxWidth*0.5,
                                             child: RadioListTile(title:  Text('Administrator',style: TextStyle(color: Colors.black,fontSize: 12.sp),), value: AccountType.Administrator,
                                               groupValue: _accountType,
                                               onChanged: (AccountType? value) {
                                                 setState(() {
                                                   _accountType = value;
                                                 });
                                               },),
                                           ),
                                           Container(
                                             height:constraint.maxHeight*0.1,
                                             width:constraint.maxWidth*0.5,
                                             child: RadioListTile(title:  Text('Student',style: TextStyle(color: Colors.black,fontSize: 12.sp)), value: AccountType.Student,
                                               groupValue: _accountType,
                                               onChanged: (AccountType? value) {
                                                 setState(() {
                                                   _accountType = value;
                                                 });
                                               },),
                                           ),
                                           // ListTile(
                                           //   title: const Text('Administrator'),
                                           //   leading: Radio<AccountType>(
                                           //     value: AccountType.Administrator,
                                           //     groupValue: _accountType,
                                           //     onChanged: (AccountType? value) {
                                           //       setState(() {
                                           //         _accountType = value;
                                           //       });
                                           //     },
                                           //   ),
                                           // ),
                                           // ListTile(
                                           //   title: const Text('Student'),
                                           //   leading: Radio<AccountType>(
                                           //     value: AccountType.Student,
                                           //     groupValue: _accountType,
                                           //     onChanged: (AccountType? value) {
                                           //       setState(() {
                                           //         _accountType = value;
                                           //       });
                                           //     },
                                           //   ),
                                           // ),
                                         ],
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                                         child: Container(
                                           width: double.infinity,
                                           child: NeumorphicStuffs().getImportantButton(
                                               text: 'Register',
                                               ontapped: () async {
                                                 if (_formKey.currentState!
                                                     .validate() /*&& isChecked!*/) {
                                              API api=API();
                                              Map<String,dynamic> response=await api.register(usernameController.text, firstNameController.text, lastNameController.text, emailController.text, phoneNumberController.text
                                                  , passwordController.text);
                                              if(response['success'])
                                                {
                                                 UserAlbum response=await  api.login(emailController.text, passwordController.text);
                                                 print("reg login response=$response");
                                                 if(response.success!)
                                                 {
                                                   SharedPreferences preferences=await SharedPreferences.getInstance();
                                                   preferences.setString(Constants.TOKEN, "${response.token}");

                                                   preferences.setString(Constants.EMAIL, "${response.data!.email}");
                                                   preferences.setString(Constants.UserId, "${response.data!.id}");
                                                   preferences.setBool(Constants.LOGIN_STATUS,true);
                                                   UserProvider provider=Provider.of<UserProvider>(context,listen: false);

                                                   provider.username=response.data!.nickname!;
                                                   provider.email=response.data!.email!;
                                                   provider.firstname=response.data!.firstName!;
                                                   provider.lastname=response.data!.lastName!;
                                                   provider.phoneNumber=response.data!.phone!;
                                                   provider.id=response.data!.id!;
                                                   provider.token=response.token!;


                                                   provider.userRoleId=response.data!.userRoles![0].userRoleId!;
                                                   provider.roleId=response.data!.userRoles![0].role!.roleId!;
                                                   provider.roleName=response.data!.userRoles![0].role!.roleName!;
                                                   provider.enabled=response.data!.enabled!;

                                                   provider.isloading=LoadingStatus.notLoading;
                                                   provider.isInitialized=true;
                                                   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>NavPage()),);
                                                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>StudentNavPage()), (route) => false);
                                                 }
                                                 else {
                                                   Fluttertoast.showToast(msg: "Login Successful");
                                                 }
                                                }
                                              else
                                                {
                                                  Fluttertoast.showToast(msg: response["message"]);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.displaySmall!.color,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                               LoginPage()));
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: darkTextColor,
                                    ),
                                  ),
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
