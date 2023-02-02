import 'package:quiztime/Registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'Api.dart';
class OtpVerification extends StatefulWidget {
   OtpVerification({Key? key,required this.email
  }) : super(key: key);
String email;
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
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
                height: constraint.maxHeight*0.3,
                decoration:  BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
                width: constraint.maxWidth*0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Enter the otp obtained on your email",style: TextStyle(color:Colors.black),textAlign: TextAlign.start,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OTPTextField(
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
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>RegistrationPage(email:widget.email)), (route) => route.isFirst);

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
              )
            ],
          );
        }),
      ),
    );
  }
}
