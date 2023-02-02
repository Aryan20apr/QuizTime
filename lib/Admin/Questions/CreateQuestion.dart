import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Albums/QuestionAlbum.dart';
import '../../Albums/QuestionUpdateAlbum.dart';
import '../../Albums/QuizAlbum.dart';
import '../../Api.dart';
import '../../provider/user_provider.dart';
import '../../util/neumorphic_stuffs.dart';

class CreateQuestion extends StatefulWidget {
  CreateQuestion({Key? key, required this.quiz})
      : super(key: key);
  QuizData quiz;

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController descriptionController;
  late TextEditingController option1Controller;
  late TextEditingController option2Controller;
  late TextEditingController option3Controller;
  late TextEditingController option4Controller;
  late TextEditingController answerController;
  bool? _isActive;

  void initState() {
    descriptionController = TextEditingController();
    option1Controller = TextEditingController();
    option2Controller = TextEditingController();
    option3Controller = TextEditingController();
    option4Controller = TextEditingController();
    answerController = TextEditingController();


  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    print('Build of create called');
    Color? textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // actions: [IconButton(onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (route)=>QuestionsList(quiz:widget.quiz)));
          // }, icon: const Icon(Icons.edit_note_rounded))],
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          title: Text(
            "Add a question to your quiz",
            style:
            TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: LayoutBuilder(builder: (context, constraint) {
              return Column(
                children: [
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextDescription(description: "Question Description:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                //readOnly: true,
                                //initialValue: '${widget.quiz.category!.cid}',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                controller: descriptionController,
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.q,
                                    ),
                                    hintText: 'Question Statement',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                              ),
                            ),
                          ),
                          TextDescription(description: "Option 1:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                controller: option1Controller,
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.a,
                                    ),
                                    hintText: 'Option 1',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Option cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          TextDescription(description: "Option2:"),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Option cannot be empty';
                                  }
                                  return null;
                                },
                                controller: option2Controller,
                                keyboardType: TextInputType.emailAddress,
                                maxLines: 1,
                                /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.b,
                                    ),
                                    hintText: 'Option2*',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                              ),
                            ),
                          ),
                          TextDescription(description: "Option 3:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Option cannot be empty';
                                  }
                                  return null;
                                },
                                controller: option3Controller,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                /*decoration: TextFieldDecor(
                                              text: 'Email',
                                              iconInfo: Icons.mail_outline_outlined)
                                              .addTextDecorWithIcon(),*/
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.c,
                                    ),
                                    hintText: 'Option 3*',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                              ),
                            ),
                          ),
                          TextDescription(description: "Option 4:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter marks between 1 and 100';
                                  }
                                  return null;
                                },
                                controller: option4Controller,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.d,
                                    ),
                                    hintText: 'Option 4*',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                              ),
                            ),
                          ),
                          TextDescription(description: "Answer:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            child: Neumorphic(
                              style: NeumorphicStuffs().getTextFieldStyle(),
                              child: TextFormField(
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.sp),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter correct answer';
                                  }
                                  return null;
                                },
                                controller: answerController,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                /*decoration: TextFieldDecor(
                                                  text: 'Email',
                                                  iconInfo: Icons.mail_outline_outlined)
                                                  .addTextDecorWithIcon(),*/
                                decoration: InputDecoration(
                                    focusedErrorBorder:
                                    const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.redAccent),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.greenAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      color: Colors.black,
                                      FontAwesomeIcons.circleCheck,
                                    ),
                                    hintText: 'Answer*',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 12.sp)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    child: Container(
                      width: double.infinity,
                      child: NeumorphicStuffs().getImportantButton(
                          text: 'Create Question',
                          ontapped: () async {
                            if (_formKey.currentState!
                                .validate() /*&& isChecked!*/) {
                              QuestionUpdateAlbum questionUpdateAlbum =
                              await createQuestion(
                                  widget.quiz.qid!,
                                  descriptionController.text,
                                  option1Controller.text,
                                  option2Controller.text,
                                  option3Controller.text,
                                  option4Controller.text,
                                  answerController.text);
                              if (questionUpdateAlbum.success == true)
                                Fluttertoast.showToast(
                                    msg: "Question created Successfully");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Could not create question");
                            }
                          }),
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

  Future<QuestionUpdateAlbum> createQuestion(
      int questionid,
      String content,
      String option1,
      String option2,
      String option3,
      String option4,
      String ans) async {
    API api = API();

    QuestionUpdateAlbum questionUpdateAlbum = await api.createQuestion(
        questionid, content, option1, option2, option3, option4, ans);
    //QuizAlbum quizAlbum=await api.updateQuiz(quiz,userid);
    return questionUpdateAlbum;
  }
}

class TextDescription extends StatelessWidget {
  TextDescription({super.key, required this.description});
  String description;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$description',
            style: TextStyle(
                color: Theme.of(context).textTheme.displayMedium?.color,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp),
            textAlign: TextAlign.start,
          ),
        ));
  }
}
