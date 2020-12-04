//Stackoverflow Code

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class FollowerNotification extends StatefulWidget {
//   static final String id = 'chat_list';
//   final String currentUserId;
//   final String peerId;
//   final User user;
//   FollowerNotification({Key key, this.currentUserId, this.peerId, this.user})
//       : super(key: key);

//   @override
//   State createState() =>
//       FollowerNotificationState(currentUserId: currentUserId);
// }

// class FollowerNotificationState extends State<FollowerNotification> {
//   FollowerNotificationState({Key key, @required this.currentUserId});

//   final String currentUserId;
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   // final GoogleSignIn googleSignIn = GoogleSignIn();
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     registerNotification();
//     configLocalNotification();
//   }

//   void registerNotification() {
//     firebaseMessaging.requestNotificationPermissions();
//     firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) {
//         print('onMessage: $message');
//         // Platform.isAndroid
//             // ? showNotification(message['notification'])
//             // : showNotification(message['aps']['alert']);
//         return;
//       },
//       onResume: (Map<String, dynamic> message) {
//         print('onResume: $message');
//         return;
//       },
//       onLaunch: (Map<String, dynamic> message) {
//         print('onLaunch: $message');
//         return;
//       },
//     );

//     firebaseMessaging.getToken().then(
//       (token) {
//         print('token: $token');
//         Firestore.instance
//             .collection('users')
//             .document(widget.currentUserId)
//             .updateData({'pushToken': token});
//       },
//     ).catchError(
//       (err) {
//         Fluttertoast.showToast(msg: err.message.toString());
//       },
//     );
//   }

//   void configLocalNotification() {
//     var initializationSettingsAndroid =
//         new AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = new IOSInitializationSettings();
//     var initializationSettings = new InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void showNotification(message) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//       Platform.isAndroid
//           ? 'com.dfa.flutterchatdemo'
//           : 'com.duytq.flutterchatdemo',
//       'Flutter chat demo',
//       'your channel description',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.Max,
//       priority: Priority.High,
//     );
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

//     print(message);
//     print(message['body'].toString());
//     print(json.encode(message));

//     await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
//         message['body'].toString(), platformChannelSpecifics,
//         payload: json.encode(message));

//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }
// }
