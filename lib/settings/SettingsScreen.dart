import 'package:quiztime/LoginPage.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../util/Constants.dart';
import 'AccountSettings.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    UserProvider provider=Provider.of<UserProvider>(context);
    return SafeArea(child: Scaffold(

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.greenAccent.shade100,borderRadius: BorderRadius.circular(20)),
                height: 18.h,
                child: LayoutBuilder(
                  builder: (context,userDetailConstraint) {
                    return Row(
                      
                      children: [
                        
                        Expanded(child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Hello ${provider.firstname},',style: GoogleFonts.sourceSansPro(color: Colors.black,fontSize: 20.sp),),
                                Text('Email: ${provider.email}',style: GoogleFonts.sourceSansPro(color: Colors.black,fontSize: 12.sp),),
                                Text('Phone: ${provider.phoneNumber}',style: GoogleFonts.sourceSansPro(color: Colors.black,fontSize: 12.sp),),
                                Text('Username: ${provider.username}',style: GoogleFonts.sourceSansPro(color: Colors.black,fontSize: 12.sp),)
                              ],
                            ),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            radius: userDetailConstraint.maxWidth*0.1,
                            backgroundColor: Colors.grey ,
                          ),
                        ),

                      ],
                    );
                  }
                ),
              ),
            ),
            SettingsItem(icon: Icons.account_box_outlined,option: "Account Settings",onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (route)=>AccountSettings()));
            },),
            SettingsItem(icon: Icons.login_outlined,option: "Sign Out",onTap: ()async
            {
             SharedPreferences preferences=await SharedPreferences.getInstance();
             preferences.setBool(Constants.LOGIN_STATUS,false);
             provider.isloading=LoadingStatus.loading;
             provider.isInitialized=false;
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route)=>LoginPage()), (route) => false);
            },),
          ],
        ),
      ),
    ));
  }
}

class SettingsItem extends StatelessWidget {
   SettingsItem({
    super.key,required this.icon,required this.option, this.onTap
  });
  IconData icon;
  String option;
   final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border(),color: Colors.green.shade50),
        height:8.h,
        width:90.h,
        child: Align(
          alignment: Alignment.center,
          child: ListTile(

            style: ListTileStyle.list,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: onTap,
            enableFeedback: true,
            focusColor: Colors.grey,
            leading: Icon(icon,color: Colors.black,),
            title: Text(option,style: GoogleFonts.lato(color: Colors.black),),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
          ),
        ),
      ),
    );
  }
}
