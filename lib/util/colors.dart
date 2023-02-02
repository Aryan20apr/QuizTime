import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF383737);
const buttonColor = Color(0xFF279c43);
const textColor = Colors.white;
const darkTextColor = Color(0xFF0e6626);

const kSecondaryColor = Color(0xFF8B94BC);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kSelectedAnswer=Color(0xFF6AE792);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;


//Validator Logic
// if (_formKey.currentState!.validate()) {
// // If the form is valid, display a snackbar. In the real world,
// // you'd often call a server or save the information in a database.
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(content: Text('Processing Data')),
// );
// }