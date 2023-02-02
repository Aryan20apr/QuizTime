import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Api.dart';
import '../util/Constants.dart';
import '../util/neumorphic_stuffs.dart';
class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
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


  }
  @override
  Widget build(BuildContext context) {

    UserProvider provider=Provider.of<UserProvider>(context);
    usernameController.text=provider.username;
    firstNameController.text=provider.firstname;
    lastNameController.text=provider.lastname;
    emailController.text=provider.email;
    phoneNumberController.text=provider.phoneNumber;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Account Settings",style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),

        ),
        body: Container(
        child: LayoutBuilder(builder: (context,constraint){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: constraint.maxWidth*0.1,
                      backgroundColor: Colors.grey ,
                    ),
                  ),
                ),
              ),
              
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: '${provider.id}',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                 /* validator: (value) {


                                    if (value == null ||
                                        value.isEmpty ) {
                                      return 'First name cannot be empty';
                                    }
                                    return null;
                                  },*/

                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                  decoration: InputDecoration(
                                      focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.redAccent),),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.greenAccent),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),),
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                      hintText: 'User id',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: provider.roleName=='ROLE_ADMIN'?'Administrator':'Student',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),


                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                  decoration: InputDecoration(

                                      focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.redAccent),),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.greenAccent),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),),
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                      hintText: 'Account type',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                        child: Neumorphic(
                          style: NeumorphicStuffs().getTextFieldStyle(),
                          child: TextFormField(

                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
                            validator: (value) {


                              if (value == null ||
                                  value.isEmpty ) {
                                return 'Nickname cannot be empty';
                              }
                              return null;
                            },
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            /*decoration: TextFieldDecor(
                                                text: 'Email',
                                                iconInfo: Icons.mail_outline_outlined)
                                                .addTextDecorWithIcon(),*/
                            decoration: InputDecoration(

                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.redAccent),),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.greenAccent),),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black),),
                                prefixIcon:Icon(color:Colors.black,Icons.account_circle_sharp,),
                                hintText: 'Nickname*',
                                hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(

                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                  validator: (value) {


                                    if (value == null ||
                                        value.isEmpty ) {
                                      return 'First name cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: firstNameController,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                  decoration: InputDecoration(
                                      focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.redAccent),),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.greenAccent),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),),
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                      hintText: 'First Name*',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(

                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                  validator: (value) {


                                    if (value == null ||
                                        value.isEmpty ) {
                                      return 'Last name cannot be empty';
                                    }
                                    return null;
                                  },
                                  controller: lastNameController,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                  decoration: InputDecoration(
                                      focusedErrorBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.redAccent),),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.greenAccent),),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.black),),
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                      hintText: 'Last Name*',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                        child: Neumorphic(
                          style: NeumorphicStuffs().getTextFieldStyle(),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
                            /*validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (value == null ||
                                  value.isEmpty ||
                                  !regex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },*/
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            /*decoration: TextFieldDecor(
                                                text: 'Email',
                                                iconInfo: Icons.mail_outline_outlined)
                                                .addTextDecorWithIcon(),*/
                            decoration: InputDecoration(
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.redAccent),),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.greenAccent),),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black),),
                                prefixIcon:Icon(color:Colors.black,Icons.mail_outline_outlined,),
                                hintText: 'Email*',
                                hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                        child: Neumorphic(
                          style: NeumorphicStuffs().getTextFieldStyle(),
                          child: TextFormField(

                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
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
                            /*decoration: TextFieldDecor(
                                                text: 'Email',
                                                iconInfo: Icons.mail_outline_outlined)
                                                .addTextDecorWithIcon(),*/
                            decoration: InputDecoration(
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.redAccent),),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.greenAccent),),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Colors.black),),
                                prefixIcon:Icon(color:Colors.black,Icons.phone_android_rounded,),
                                hintText: 'Phone Number*',
                                hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  child: NeumorphicStuffs().getImportantButton(
                      text: 'Update Profile',
                      ontapped: () async {
                        if (_formKey.currentState!
                            .validate() /*&& isChecked!*/) {
                          API api = API();
                          Map<String, dynamic> response = await api.updateUser(
                              usernameController.text, firstNameController.text,
                              lastNameController.text, emailController.text,
                              phoneNumberController.text);
                          if (response['success']) {
                            provider.updateUser(response['data']['nickname'],
                                response['data']['firstName'],
                                response['data']['lastName']);
                            Navigator.pop(context);
                          }
                          else
                            {
                              Fluttertoast.showToast(msg: "Could not update user");
                            }
                        }
                      }

                  ),
                ),
              ),

            ],
          );
        }),
        ),

      ),
    );
  }
}
