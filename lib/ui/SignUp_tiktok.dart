// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:tik_tok_app/ColorsClass/Colors.dart';
// import 'package:tik_tok_app/Components/TextView.dart';
// import 'package:tik_tok_app/Contants/Constant.dart';
// import 'package:tik_tok_app/Contants/FieldsData.dart';
// import 'package:tik_tok_app/MediaQuery/ScreenUtils.dart';
// import "package:http/http.dart" as http;

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

// class SignUpScreen extends StatefulWidget {
//   String title;
//   SignUpScreen({this.title});
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return SignUpScreenState();
//   }
// }

// class SignUpScreenState extends State<SignUpScreen> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;
//   int currentView;

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil(
//       allowFontScaling: true,
//     )..init(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: getView(currentView),
//     );
//   }

//   void googleSignInCurrentUserChanged() {
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//     });
//   }

//   Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = "Loading contact info...";
//     });
//     final http.Response response = await http.get(
//       'https://people.googleapis.com/v1/people/me/connections'
//       '?requestMask.includeField=person.names',
//       headers: await _currentUser.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         _contactText = "People API gave a ${response.statusCode} "
//             "response. Check logs for details.";
//       });
//       print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data = json.decode(response.body);
//     final String namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         _contactText = "I see you know $namedContact!";
//       } else {
//         _contactText = "No contacts to display.";
//       }
//     });
//   }

//   String _pickFirstNamedContact(Map<String, dynamic> data) {
//     final List<dynamic> connections = data['connections'];
//     final Map<String, dynamic> contact = connections?.firstWhere(
//       (dynamic contact) => contact['names'] != null,
//       orElse: () => null,
//     );
//     if (contact != null) {
//       final Map<String, dynamic> name = contact['names'].firstWhere(
//         (dynamic name) => name['displayName'] != null,
//         orElse: () => null,
//       );
//       if (name != null) {
//         return name['displayName'];
//       }
//     }
//     return null;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   getView(int view) {
//     switch (view) {
//       case 0:
//         return splashScreen();
//         break;
//       case 1:
//         return signUpModule();
//         break;
//       default:
//         {
//           Center(
//             child: Text("Not Set View"),
//           );
//         }
//         break;
//     }
//   }

//   Widget splashScreen() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image(
//             image: AssetImage(splashScreenImage),
//             fit: BoxFit.fill,
//           ),
//           Center(
//             child: TextView(
//               text: "BS\nTIK TOK",
//               fondFamily: "helvetica_neue_bold",
//               maxLine: 2,
//               color: Colors_.white,
//               fontSize: 35,
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget signUpModule() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: Colors_.black,
//         image: DecorationImage(
//           image: AssetImage(
//             signUpBackgroundImage,
//           ),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width / 1.3,
//           height: MediaQuery.of(context).size.height / 1.6,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(40)),
//             boxShadow: [BoxShadow(blurRadius: 20, color: Colors_.shadeColor)],
//             color: Colors_.white,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding:
//                     EdgeInsets.only(top: 30, bottom: 10, left: 40, right: 40),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     TextView(
//                       text: "You Need a Let Tok account to Continue",
//                       fondFamily: "helvetica_neue_bold",
//                       maxLine: 2,
//                       fontSize: 18,
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     MaterialButton(
//                       child: TextView(
//                         text: "Sign Up",
//                         fondFamily: "helvetica_neue_bold",
//                         fontSize: 16,
//                         color: Colors_.white,
//                       ),
//                       minWidth: 200,
//                       height: 50,
//                       color: Colors_.buttonColor,
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushNamed(numberVerificationPagePath);
//                       },
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 2,
//                             color: Colors_.borderLine,
//                           ),
//                         ),
//                         TextView(
//                           text: "OR ",
//                           fondFamily: "helvetica_neue_bold",
//                           maxLine: 2,
//                           fontSize: 14,
//                           textAlign: TextAlign.center,
//                         ),
//                         Expanded(
//                           child: Container(
//                             height: 2,
//                             color: Colors_.borderLine,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                             child: Image(image: AssetImage(facebookIcon))),
//                         GestureDetector(
//                             onTap: _handleSignIn,
//                             child: Image(image: AssetImage(googleIcon))),
//                         GestureDetector(
//                             child: Image(image: AssetImage(instagramIcon))),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(bottom: 50, left: 30, right: 30),
//                 child: TextView(
//                   text:
//                       "Login in means you agree Let Tok's Terms of Service Broadcaster Agreement and Privacy Policy powered by Let Tok video",
//                   fondFamily: "helvetica_neue_medium",
//                   maxLine: 4,
//                   fontSize: 10,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     currentView = 0;
//     Future.delayed(Duration(milliseconds: 3000), () {
//       // 5s over, navigate to a new page
//       setState(() {
//         currentView = 1;
//       });
//     });
//     super.initState();
//   }
// }
