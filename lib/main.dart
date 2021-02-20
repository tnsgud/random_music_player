import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_music_player/screens/Home.dart';
import 'screens/Loading.dart';

void main() {
  runApp(MyApp());
}

// 이것은 확인용 주석입니다. 1
// 이것은 확인용 주석입니다. 2

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.purple[800]),
        primaryColor: Colors.white,
        accentColor: Colors.purple[800],
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.purple[800]),
        primaryColor: Colors.black,
        accentColor: Colors.purple[800],
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Colors.black),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  void setData() {}

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // CollectionReference user = FirebaseFirestore.instance.collection('songs');
    // void _showError() {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           backgroundColor: theme.primaryColor,
    //           title: Text(
    //             'Error',
    //             style: TextStyle(color: theme.accentColor),
    //           ),
    //           content: Text(
    //             "에러가 발생했습니다.\n인터넷이 켜져있는지 확인해주세요.\n그래도 문제가 있다면 앱을\n재실행 해주시거나\n개발자에게 문의해주세요!",
    //             style: theme.textTheme.bodyText1,
    //           ),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child:
    //                     Text('닫기', style: TextStyle(color: theme.accentColor)))
    //           ],
    //         );
    //       });
    // }

    print("$_error///$_initialized");
    if (_error) {
      print('error');
      // _showError();
    } else if (!_initialized) {
      print('Loading');
      return Loading();
    } else {
      print('Home');
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home())));
    }
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: TextButton(
    //       child: Text("asdf"),
    //       onPressed: () {
    //         Map<String, dynamic> title;
    //         FirebaseFirestore.instance
    //             .collection("songs")
    //             .doc("song0")
    //             .get()
    //             .then((DocumentSnapshot ds) {
    //           title = ds.data();
    //           print(title);
    //         }).catchError((error) => print(error));
    //       },
    //     ),
    //   ),
    //   body: Column(
    //     children: [Text('hello')],
    //   ),
    // );
    return Loading();
  }
}
