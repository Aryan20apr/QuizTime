import 'package:quiztime/Albums/QuizAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/provider/ActiveProvider.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/CategoryAlbum.dart';
import '../../Api.dart';
import '../../util/neumorphic_stuffs.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class CreateCategory extends StatefulWidget {
  CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;



  void initState()
  {
    titleController = TextEditingController();
    descriptionController = TextEditingController();




  }
  @override
  Widget build(BuildContext context) {
    UserProvider provider=Provider.of<UserProvider>(context);

    Color? textColor=Theme.of(context).textTheme.bodyMedium?.color;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("New Quiz",style:TextStyle(color:Theme.of(context).appBarTheme.foregroundColor)),

        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: LayoutBuilder(builder: (context,constraint){
              return Column(
                children: [


                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [


                          TextDescription(description: "Category Title:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(

                                style: TextStyle(color: textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                validator: (value) {


                                  if (value == null ||
                                      value.isEmpty ) {
                                    return 'Title must be specified';
                                  }
                                  return null;
                                },
                                controller: titleController,
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
                                    hintText: 'Title*',
                                    hintStyle: TextStyle(color:textColor,fontSize: 12.sp)
                                ),
                              ),
                            ),
                          ),
                          TextDescription(description: "Description:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                maxLength: 200,
                                style: TextStyle(color:textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                validator: (value) {


                                  if (value == null ||
                                      value.isEmpty ) {
                                    return 'First name cannot be empty';
                                  }
                                  return null;
                                },
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                maxLines: 3,
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

                                    hintText: 'Description of quiz*',
                                    hintStyle: TextStyle(color:textColor,fontSize: 12.sp)
                                ),
                              ),
                            ),
                          ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                    child: Container(
                      width: double.infinity,
                      child: NeumorphicStuffs().getImportantButton(
                          text: 'Create Category',
                          ontapped: () async {
                            if (_formKey.currentState!
                                .validate() /*&& isChecked!*/) {

                              CategoryAlbum categoryAlbum= await createCategory(CategoryData(cid:null,title:titleController.text,description:descriptionController.text),provider.id);
                              if(categoryAlbum.success==true)
                                Fluttertoast.showToast(msg: "New Quiz Created");
                            }
                            else
                            {
                              Fluttertoast.showToast(msg: "Could not create");
                            }
                          }


                      ),
                    ),
                  ),


                ],
              )
              )
              )]
              );
            }),
          ),
        ),

      ),
    );
  }

  Future<CategoryAlbum> createCategory(CategoryData categoryData,int userid) async
  {
    API api=API();
    UserProvider provider=Provider.of<UserProvider>(context,listen: false);
    CategoryAlbum categoryAlbum=await api.createCategory(categoryData,userid);
    return categoryAlbum;
  }
}

class TextDescription extends StatelessWidget {
  TextDescription({
    super.key,required this.description
  });
  String description;
  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft,child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$description',style:TextStyle(color:Theme.of(context).textTheme.displayMedium?.color,fontWeight: FontWeight.bold,fontSize: 15.sp),textAlign: TextAlign.start,),
    ));
  }
}
