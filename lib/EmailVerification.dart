import 'package:quiztime/Api.dart';
import 'package:quiztime/util/neumorphic_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import 'OTPVerificationScreen.dart';
class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;

  late TextEditingController otpController;
  void initState()
  {

    emailController = TextEditingController();

    otpController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width:width,
        child: LayoutBuilder(builder: (context,constraint){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                key: _formKey,
                  child: Container(
                    width: constraint.maxWidth*0.9,
                    height: height*0.7,
                    decoration:  BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Image.asset("assets/Login_Page.jpg"),

                      Neumorphic(
                        style: NeumorphicStuffs().getTextFieldStyle(),
                        child: TextFormField(

                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
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
                  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: ()async {
                          if(_formKey.currentState!.validate())
                            {

                                  Map<String,dynamic> response=await API().sendotp(emailController.text);
                                  if(response['success'])
                                    {
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>OtpVerification(email:emailController.text)), (route) => route.isFirst);

                                    }
                                  else
                                    {
                                      //Show toast message
                                    }
                            }
                        },
                        icon: Icon(Icons.password_sharp),
                        label: Text("Send OTP"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(30.w,8.h),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                  )
                ],
              ),
                    ),
                  ))
            ],
          );
        }),
      ),
    );
  }
}
