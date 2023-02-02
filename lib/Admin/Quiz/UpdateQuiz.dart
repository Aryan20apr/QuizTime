import 'package:quiztime/Admin/Albums/UpdateQuiz.dart';
import 'package:quiztime/Albums/QuizAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/provider/ActiveProvider.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/CategoryAlbum.dart';
import '../../Api.dart';
import '../../util/neumorphic_stuffs.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../Questions/AllQuestions.dart';

class UpdateQuiz extends StatefulWidget {
  UpdateQuiz({Key? key,required  this.quiz}) : super(key: key);
  QuizData quiz;
  @override
  State<UpdateQuiz> createState() => _UpdateQuizState();
}

class _UpdateQuizState extends State<UpdateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController maxMarksController;
  late TextEditingController numberOfQuestionsController;
  bool? _isActive;



  void initState()
  {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    maxMarksController = TextEditingController();
    numberOfQuestionsController = TextEditingController();

    titleController.text=widget.quiz.title!;
    descriptionController.text=widget.quiz.description!;
    maxMarksController.text=widget.quiz.maxMarks!.toString();
    numberOfQuestionsController.text=widget.quiz.numberOfQuestions!.toString();


  }
  @override
  Widget build(BuildContext context) {
    UserProvider provider=Provider.of<UserProvider>(context);
    print('Build of updateQuiz called');
    Color? textColor=Theme.of(context).textTheme.bodyMedium?.color;

    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(

          resizeToAvoidBottomInset: false,
          appBar: AppBar(

            actions: [IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (route)=>QuestionsList(quiz:widget.quiz)));
            }, icon: const Icon(Icons.edit_note_rounded))],
            foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
            title: Text("${widget.quiz.title}",style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),),

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
                            TextDescription(description: "Category Id:"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),

                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: '${widget.quiz.category!.cid}',
                                  style: TextStyle(color:textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),

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
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.idCard,),
                                      hintText: 'Category Id',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                            TextDescription(description: "Category Name:"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: widget.quiz.category!.title,
                                  style: TextStyle(color:textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),



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
                                      prefixIcon:Icon(color:Colors.black,Icons.category,),
                                      hintText: 'Category Name',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                            TextDescription(description: "Quiz Title:"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(

                                  style: TextStyle(color:textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
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
                                      prefixIcon:Icon(color:Colors.black,Icons.wrap_text,),
                                      hintText: 'Title*',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
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
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)
                                  ),
                                ),
                              ),
                            ),
                            TextDescription(description: "Maximum Marks:"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                              child: Neumorphic(
                                style: NeumorphicStuffs().getTextFieldStyle(),
                                child: TextFormField(

                                  style: TextStyle(color:textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),
                                  validator: (value) {
                                    String patttern = r'(^[1-9][0-9]?$|^100$)';
                                    RegExp regExp = new RegExp(patttern);
                                    print("/*/*");
                                    print(value==null);
                                    print(value?.isEmpty);
                                    print(value?.length);
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length <=1|| value.length>=100 /*||
                                        !regExp.hasMatch(value)*/) {
                                      return 'Please enter marks between 1 and 100';
                                    }
                                    return null;
                                  },
                                  controller: maxMarksController,
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
                                      prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.marker,),
                                      hintText: 'Maximum Marks*',
                                      hintStyle: TextStyle(color:Colors.black,fontSize: 12.sp)

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    TextDescription(description: "Enable to make the quiz active and visible to students:"),
                    ChangeNotifierProvider(
                      create: (BuildContext context) {  return QuizActiveProvider(); },
                      child: Consumer<QuizActiveProvider>(builder: (context,activeprovider,child){
                        activeprovider.isActive=widget.quiz.active!;
                        return AnimatedToggleSwitch.rolling(borderColorBuilder:(b) {
                          print(b);
                          print("## ${activeprovider.isActive}");
                          return b ? Colors.green : Colors.red;

                        } ,colorBuilder: (b) => b ? Colors.green : Colors.red,current:activeprovider.isActive , values: const [false,true],onTap: (){
                          activeprovider.changeIsActive();
                          widget.quiz.active=activeprovider.isActive;
                          // _isActive=activeprovider.isActive;
                          print('Called on tap');
                        }/*,onChanged: (value){
                          print("Called onChanged");
                          activeprovider.changeIsActive();
                        }*/,);}),
                    ),
                    /* Row(

                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        SizedBox(
                          height:constraint.maxHeight*0.1,
                          width:constraint.maxWidth*0.5,
                          child: RadioListTile<QuizActive>(title:  Text('Active',style: TextStyle(color:textColor,fontSize: 12.sp),), value: QuizActive.Active,
                            groupValue: _isActive,
                            onChanged: (QuizActive? value) {
                              setState(() {
                                _isActive = value;
                              });
                            },),
                        ),
                        SizedBox(
                          height:constraint.maxHeight*0.1,
                          width:constraint.maxWidth*0.5,
                          child: RadioListTile<QuizActive>(title:  Text('Inactive',style: TextStyle(color:textColor,fontSize: 12.sp)), value: QuizActive.NotActive,
                            groupValue: _isActive,
                            onChanged: (QuizActive? value) {
                              setState(() {
                                _isActive = value;
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
                    ),*/
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                      child: Container(
                        width: double.infinity,
                        child: NeumorphicStuffs().getImportantButton(
                            text: 'Update Quiz',
                            ontapped: () async {
                              if (_formKey.currentState!
                                  .validate() /*&& isChecked!*/) {
                                _isActive=widget.quiz.active!;
                                QuizAlbum quizAlbum= await updateQuiz(widget.quiz,titleController.text,descriptionController.text,maxMarksController.text,_isActive!,provider.id);
                                 if(quizAlbum.success==true)
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
                );
              }),
            ),
          ),

        ),
      ),
    );
  }

  Future<bool> onBackPressed()async {
      if(_isActive!=null&&_isActive==false)
        {
          print("_isActive is $_isActive");
          widget.quiz.active=false;
        }
      return true;
    }

  Future<QuizAlbum> updateQuiz(QuizData quiz, String title, String description, String maxMarks, bool isActive,int userid) async
  {
    API api=API();

    quiz.title=title;
    quiz.description=description;
    quiz.maxMarks=int.parse(maxMarks);
    quiz.active=isActive;
    QuizAlbum quizAlbum=await api.updateQuiz(quiz,userid);
    return quizAlbum;
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
