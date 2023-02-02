import 'package:quiztime/Albums/QuizAlbum.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/provider/ActiveProvider.dart';
import 'package:quiztime/provider/user_provider.dart';
import 'package:quiztime/util/Constants.dart';
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

class CreateQuiz extends StatefulWidget {
   CreateQuiz({Key? key,required  this.category}) : super(key: key);
  CategoryData category;
  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController maxMarksController;
  late TextEditingController numberOfQuestionsController;
  bool _isActive=false;


  void initState()
  {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    maxMarksController = TextEditingController();
    numberOfQuestionsController = TextEditingController();



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
                          TextDescription(description: "Category Id:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),

                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: '${widget.category.cid}',
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
                                    prefixIcon:Icon(color:Colors.black,FontAwesomeIcons.user,),
                                    hintText: 'Category Id',
                                    hintStyle: TextStyle(color:textColor,fontSize: 12.sp)
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
                                initialValue: widget.category.title,
                                style: TextStyle(color: textColor,fontWeight: FontWeight.normal,fontSize: 13.sp),



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
                                    hintText: 'Category Name',
                                    hintStyle: TextStyle(color:textColor,fontSize: 12.sp)
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
                          TextDescription(description: "Maximum Marks:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(

                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 13.sp),
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
                                    prefixIcon:Icon(color:Colors.black,Icons.phone_android_rounded,),
                                    hintText: 'Maximum Marks*',
                                    hintStyle: TextStyle(color:textColor,fontSize: 12.sp)

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
                   child: Consumer<QuizActiveProvider>(builder: (context,activeprovider,_){
                     activeprovider.isActive=_isActive;
                     return AnimatedToggleSwitch.rolling(borderColorBuilder:(b) {
                       print(b);
                       print("## ${activeprovider.isActive}");
                       return b ? Colors.green : Colors.red;

                     } ,colorBuilder: (b) => b ? Colors.green : Colors.red,current:activeprovider.isActive , values: const [false,true],onTap: (){
                       activeprovider.changeIsActive();
                      // widget.quiz.active=activeprovider.isActive;
                       _isActive=activeprovider.isActive;
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
                        child: RadioListTile<QuizActive>(title:  Text('Active',style: TextStyle(color: Colors.black,fontSize: 12.sp),), value: QuizActive.Active,
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
                        child: RadioListTile<QuizActive>(title:  Text('Inactive',style: TextStyle(color: Colors.black,fontSize: 12.sp)), value: QuizActive.NotActive,
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
                          text: 'Create Quiz',
                          ontapped: () async {
                            if (_formKey.currentState!
                                .validate() /*&& isChecked!*/) {

                               QuizAlbum quizAlbum= await createQuiz(widget.category,titleController.text,descriptionController.text,maxMarksController.text,_isActive,);
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
    );
  }

  Future<QuizAlbum> createQuiz(CategoryData category, String title, String description, String maxMarks, bool isActive) async
  {
    API api=API();
    UserProvider provider=Provider.of<UserProvider>(context,listen: false);
    QuizAlbum quizAlbum=await api.createQuiz(QuizData( title:title, description:description,   maxMarks:int.parse(maxMarks),numberOfQuestions:0,   active: isActive,category:category),provider.id);
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
