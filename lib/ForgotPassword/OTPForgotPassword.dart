import 'package:quiztime/Registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../Api.dart';
import 'ResetPassword.dart';

class ForgotPasswordOTP extends StatefulWidget {
   ForgotPasswordOTP({Key? key,required this.email
  }) : super(key: key);
String email;
  @override
  State<ForgotPasswordOTP> createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
  final _formKey = GlobalKey<FormState>();

  late OtpFieldController otpController;
  String otp='';

  void initState()
  {



    otpController = OtpFieldController();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: constraint.maxWidth*0.8,
                child: Column(
                  children: [
                    const Text("Enter the otp obtained on your email",style: TextStyle(color:Colors.black),textAlign: TextAlign.start,),
                    OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 40.sp,
                      style: TextStyle(
                          fontSize: 20.sp,color: Colors.black
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) {
                            otp=pin;
                            print("pin=$pin otp=$otp");
                      },
                    ),
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: ()async {
                          print("otp=$otp");
                          if(otp.length==6)
                          {

                            Map<String,dynamic> response=await API().verifyotp(int.parse(otp),widget.email);
                            if(response['success'])
                            {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>ResetPassword(email:widget.email)), (route) => route.isFirst);

                            }
                            else
                            {
                              //Show toast message
                            }
                          }
                        },
                        icon: Icon(Icons.password_sharp),
                        label: Text("Verify"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(30.w,8.h),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
