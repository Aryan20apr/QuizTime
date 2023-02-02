import 'package:quiztime/LoginPage.dart';
import 'package:quiztime/OTPVerificationScreen.dart';
import 'package:quiztime/Registration.dart';
import 'package:quiztime/home/HomeScreen.dart';
import 'package:quiztime/home/NavPage.dart';
import 'package:quiztime/util/colors.dart';
import 'package:quiztime/util/neumorphic_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../EmailVerification.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(

        body: Container(
          color: Colors.amber.shade50,
          height: height,
          width: width,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( height:constraints.maxHeight*0.1),
                Text("All That",
                    style: GoogleFonts.rubikGlitch(
                        textStyle: TextStyle(
                            color: Colors.indigo.shade900, fontSize: 50.sp))),
                Image.asset(
                  "assets/logo.jpg",
                  height: 45.h,
                ),
                SizedBox(height: constraints.maxHeight*0.15,),
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (route)=>StudentNavPage()));
                    },
                    icon: Icon(Icons.explore),
                    label: Text("Explore"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(30.w,8.h),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(

                    decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>LoginPage()), (route) => false);},
                            icon: Icon(Icons.login),
                            label: Text("Login"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(30.w,8.h),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (route)=>EmailVerification()));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>EmailVerification()), (route) => false);
                            },
                            icon: Icon(Icons.app_registration),
                            label: Text("Register"),
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
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
