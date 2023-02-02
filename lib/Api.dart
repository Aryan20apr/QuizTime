import 'dart:convert';
import 'dart:io';

import 'package:quiztime/Admin/Albums/UpdateQuiz.dart';
import 'package:quiztime/Albums/CategoryAlbum.dart';
import 'package:quiztime/Albums/QuizHistoryAlbumStudent.dart';
import 'package:quiztime/Albums/UserAlbum.dart';
import 'package:quiztime/util/Constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Albums/AdminHistoryAlbum.dart';
import 'Albums/LoginFailAlbum.dart';
import 'Albums/QuestionAlbum.dart';
import 'Albums/QuestionUpdateAlbum.dart';
import 'Albums/QuizAlbum.dart';
import 'Albums/QuizResultAlbum.dart';
import 'Albums/UserListAlbum.dart';


class API {
  final Dio _dio = Dio();
  static const String baseURL = "https://54a9-14-139-240-85.in.ngrok.io";

  String registeration = "$baseURL/examportal/auth/register";
  String updateuser = "$baseURL/examportal/user/updateuser";
  String sendOtp = "$baseURL/examportal/auth/sendotp";
  String verifyOtp="$baseURL/examportal/auth/verifyotp";
  String generatetoken="$baseURL/examportal/auth/generate-token";
  String getuserByEmail="$baseURL/examportal/auth/getuserbyemail";
  String forgotpassword="$baseURL/examportal/auth/forgotpassword";
  String getuser="$baseURL/examportal/user/getUser";
  String getstudentsincategory="$baseURL/examportal/user/getcategorystudents";
String enroll="$baseURL/examportal/user/enrollinsubject";

  /**** Category API****/
  String allCategories="$baseURL/examportal/category/allCategories";
  String getusercategories="$baseURL/examportal/category/allCategoriesbyuser";
  String createcategory="$baseURL/examportal/category/add";
  String getcategoryofenrolleduser="$baseURL/examportal/category/getcategoriesenrolledbyuser";
  String categoriesunenrolled="$baseURL/examportal/category/categories/notenrolled";

  /***********************Quizzes***********/
  String allQuizzes="$baseURL/examportal/quiz/allquizes";
  String allActiveQuizzes="$baseURL/examportal/quiz/allactivequizes";
  String allActiveQuizzesByCategory="$baseURL/examportal/quiz/getactivebycategory";
  String allquizzesbycategory="$baseURL/examportal/quiz/allquizes";
  String allQuizzesByUser="$baseURL/examportal/quiz/getbyuser";
  String updatequiz="$baseURL/examportal/quiz/update";
  String createquiz="$baseURL/examportal/quiz/addQuiz";
  String deletequiz="$baseURL/examportal/quiz/delete";
  String evaluatequiz="$baseURL/examportal/quizscore/evalquiz";

  /**********************************Questions************************/
  String createquestion="$baseURL/examportal/question";
  String updatequestion="$baseURL/examportal/question/";
  String allquestion="$baseURL/examportal/question/allQuestions";
  String delete="$baseURL/examportal/question/byid";
  String getquestionbyid="$baseURL/examportal/question/byid";
  String questionsbyquiz="$baseURL/examportal/question/quizquestions";
  String deletequestion="$baseURL/examportal/question/byid";


  /************************ Quiz History ******************************/
  String attemptedquizzes="$baseURL/examportal/quizscore/user-attempts";
  String adminhistory="$baseURL/examportal/quizscore/attempts";

  Options getOptions(String? token)
  {
    Options options = Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {HttpHeaders.authorizationHeader:'Bearer $token'});
    return options;
  }
  Future register(String nickname, String firstName, String lastName,
      String email, String mobileNo, String password) async {
    Map<String, dynamic> body = {
      "nickname": nickname,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": mobileNo,
      "password": password
    };

    Response response = await _dio.post(registeration, data: body);
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }
  Future updateUser(String nickname, String firstName, String lastName,
      String email, String mobileNo) async {
    Map<String, dynamic> body = {
      "nickname": nickname,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": mobileNo,
      "password": '',
      "profile" : 'test.jpeg'
    };
    SharedPreferences preferences =await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    String authtoken='Bearer $token';
    Options options = Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {HttpHeaders.authorizationHeader:authtoken});
    print('Token=$token');
    Response response = await _dio.put(updateuser, data: body,options:options );
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }

  Future sendotp(String email) async {
    Map<String, dynamic> query = {
      "email": email,
    };

    Response response = await _dio.post(sendOtp, queryParameters: query);
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }

  Future verifyotp(int otp,String email) async {
    Map<String, dynamic> query = {
      "otp": otp,
      "email": email
    };
    print(query);
    Response response = await _dio.post(verifyOtp, queryParameters: query);
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }

  Future login(String email,String password) async {
    Map<String, dynamic> query = {
      "email": email,
      "password": password
    };
    print(query);
    Response response = await _dio.post(generatetoken, data: query);
    Map<String, dynamic> data = response.data;

    if(data['success'])
   { print(data);
    UserAlbum user= UserAlbum.fromJson(response.data);
    print("Success= ${user.success}");
    return UserAlbum.fromJson(response.data);}
    else
      return LoginFail.fromJson(response.data);
    //return data;
  }
  Future getUserByEmail(String email) async {
    Map<String, dynamic> query = {
      "email": email,
    };

    Response response = await _dio.get(getuserByEmail, queryParameters: query);
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }
  Future getUser(String? email,String? token) async {
    print("Email=$email");
    Map<String, dynamic> query = {
      "email": email,
    };

    print('token=$token');

    Options options = Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {HttpHeaders.authorizationHeader:'Bearer $token'});
    Response response = await _dio.get(getuser, queryParameters: query,options: options );
    print(response);
    Map<String, dynamic> data = response.data;


    return UserAlbum.fromJson(response.data);
  }
  Future<UserListAlbum> getStudentsOfCategory(int? cid) async {
   print("student in cid=$cid");

   SharedPreferences preferences=await SharedPreferences.getInstance();
   String? token=preferences.getString(Constants.TOKEN);
    Response response = await _dio.get(getstudentsincategory, queryParameters: {"cid":cid},options: getOptions(token) );
    print("students in cid=$cid $response");



    return UserListAlbum.fromJson(response.data);
  }

  Future forgotPassword(String email,String newpassword) async {
    Map<String, dynamic> query = {
      "email": email,
      "newpassword":newpassword
    };

    Response response = await _dio.post(forgotpassword, data: query);
    Map<String, dynamic> data = response.data;
    print(data);

    return data;
  }

  Future<CategoryAlbum> enrollInSubject(int userid,int cid) async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    Response response = await _dio.post(enroll, queryParameters: {"userid" : userid, "cid" : cid},options: getOptions(token));
    print("Result of enrollment $response");
    return CategoryAlbum.fromJson(response.data);

  }
  /****************** Category **************************************************/

  Future<CategoryAlbum> createCategory(CategoryData categoryData,int userid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    Response response=await _dio.post(createcategory,options: getOptions(token),queryParameters: {"userid" : userid},data:categoryData.toJson());
    return CategoryAlbum.fromJson(response.data);
  }


Future<CategoryAlbum> getAllCategoriesByUser() async
{
  print('Inside getAllCategories');
  SharedPreferences preferences=await SharedPreferences.getInstance();
  String? userid=preferences.getString(Constants.UserId);
  print('User id=$userid');
  String? token=preferences.getString(Constants.TOKEN);

  Response response=await _dio.get(getusercategories,options: getOptions(token),queryParameters: {"userid" : int.parse(userid!)});

  print("All categories= $response");
  return CategoryAlbum.fromJson(response.data);

}
  Future<CategoryAlbum> getAllCategoriesByEnrolledUser() async
  {
    print('Inside getAllCategoriesByEnrolledUser');
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? userid=preferences.getString(Constants.UserId);
    print('User id=$userid');
    String? token=preferences.getString(Constants.TOKEN);
    int user=int.parse(userid!);
    print('user=$user');
    Response response=await _dio.get(getcategoryofenrolleduser,options: getOptions(token),queryParameters: {"userid" : user});

    print("All categories= $response");
    return CategoryAlbum.fromJson(response.data);

  }
  Future<CategoryAlbum> getAllCategoriesnotenrolled() async
  {
    print('Inside getAllCategoriesByEnrolledUser');
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? userid=preferences.getString(Constants.UserId);
    print('User id=$userid');
    String? token=preferences.getString(Constants.TOKEN);
    int user=int.parse(userid!);
    print('user=$user');
    Response response=await _dio.get(categoriesunenrolled,options: getOptions(token),queryParameters: {"userid" : user});

    print("All categories= $response");
    return CategoryAlbum.fromJson(response.data);

  }
  Future<CategoryAlbum> getAllCategories() async
  {

    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.get(allCategories,options: getOptions(token));

    print("All categories= $response");
    return CategoryAlbum.fromJson(response.data);

  }


  /****************** Quizes **************************************************/



  Future getAllCActiveQuizes() async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.get(allActiveQuizzes,options: getOptions(token));

    print("All active quizzes= $response");
    return response.data;

  }
  Future<QuizAlbum> getAllCActiveQuizesByCategory(int? cid) async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    int? userid=preferences.getInt(Constants.UserId);
    Response response=await _dio.get(allActiveQuizzesByCategory,options: getOptions(token),queryParameters: {"cid" :cid,"userid":userid});

    print("All active quizzes of $cid category= $response");
    return QuizAlbum.fromJson(response.data);

  }

  Future<QuizAlbum> getAllQuizesByCategory(int? cid) async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.get(allquizzesbycategory,options: getOptions(token),queryParameters: {"cid" :cid});

    print("All active quizzes of $cid category= $response");
    return QuizAlbum.fromJson(response.data);

  }
  Future<QuizAlbum> getAllQuizzesOfCategoryByUser(int? userId,int? cid) async
  {

    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    print("userid=$userId cid=$cid");
    Response response=await _dio.get(allQuizzesByUser,options: getOptions(token),queryParameters: {"userid" :userId,"cid":cid});

    print("All quizzes of user with userid $userId category= $response");
    return QuizAlbum.fromJson(response.data);

  }

  Future<QuizAlbum> updateQuiz(QuizData updateQuizAlbum,int userId)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.put(updatequiz,data:updateQuizAlbum.toJson(),options: getOptions(token),queryParameters: {"userid" : userId});
    print("Update Quiz response is $response");
    return QuizAlbum.fromJson(response.data);
  }

  Future<QuizAlbum> createQuiz(QuizData quizData,int userid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.put(updatequiz,data:quizData.toJson(),options: getOptions(token),queryParameters: {"userid" :  userid});
    print("Create Quiz response is $response");
    return QuizAlbum.fromJson(response.data);
  }

  Future<Map<String,dynamic>> deleteQuiz(int?  qid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.delete(deletequiz,queryParameters:{"qid" : qid},options: getOptions(token));
    print("Delete response is $response");
    return response.data;
  }

  /************Questions ****************/

Future<QuestionAlbum> getQuestionsofQuiz(int qid)async
{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  String? token=preferences.getString(Constants.TOKEN);

  Response response=await _dio.get(questionsbyquiz,options: getOptions(token),queryParameters: {"quizId" :qid});

  print("All active quizzes of $qid category= $response");
  return QuestionAlbum.fromJson(response.data);
}
  Future<QuestionUpdateAlbum> createQuestion(int qid,String content,String option1,String option2,String option3,String option4,String answer)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    Map<String,dynamic> data={

      "content":content,
      "image" : "java.png",
      "option1": option1,
      "option2" :option2,
      "option3" : option3,
      "option4" : option4,
      "answer"   : answer,
    };

    Response response=await _dio.post(createquestion,data:data,options: getOptions(token),queryParameters: {"qid" :qid});

    print("Updated Question $response");
    return QuestionUpdateAlbum.fromJson(response.data);
  }
  Future<QuestionUpdateAlbum> updateQuestion(int qid,String content,String option1,String option2,String option3,String option4,String answer)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    Map<String,dynamic> data={
      "qid":qid,
      "content":content,
      "image" : "java.png",
      "option1": option1,
      "option2" :option2,
      "option3" : option3,
      "option4" : option4,
      "answer"   : answer,
    };

    Response response=await _dio.put(updatequestion,data:data,options: getOptions(token)/*,queryParameters: {"quizId" :qid}*/);

    print("Updated Question $response");
    return QuestionUpdateAlbum.fromJson(response.data);
  }
  Future deleteQuestions(int qid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.delete(deletequestion,options: getOptions(token),queryParameters: {"id" :qid});

    print("Question deleted $qid =$response");
    return response.data;
  }
  Future<QuizResultAlbum> submitQuiz(int qid,List<QuestionData> data)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    String? userid=preferences.getString(Constants.UserId);
    Response response=await _dio.post(evaluatequiz,options: getOptions(token),data: data ,queryParameters: {"quizid" :qid,"userid":userid},);

    print("Quiz result is $qid =$response");
    return QuizResultAlbum.fromJson(response.data);
  }

  /************************* Quiz History  ****************************************/
  Future<StudentHistoryAlbum> quizHistory()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);
    print('Userid for history=$token');
    String? userid=preferences.getString(Constants.UserId);
      print('Userid for history=${userid==null}');
    Response response=await _dio.get(attemptedquizzes,options: getOptions(token),queryParameters: {"id" :int.parse(userid!)},);

    print("Student Quiz History result is=$response");
    return StudentHistoryAlbum.fromJson(response.data);
  }
  Future<AdminHistoryAlbum> quizHistoryAdmin(int qid)async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString(Constants.TOKEN);

    Response response=await _dio.get(adminhistory,options: getOptions(token),queryParameters: {"qid" :qid},);

    print("Student Quiz History admin result is=$response");
    return AdminHistoryAlbum.fromJson(response.data);
  }

}
