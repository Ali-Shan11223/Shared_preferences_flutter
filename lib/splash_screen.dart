import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/admin_screen.dart';
import 'package:flutter_shared_preferences/home_screen.dart';

import 'package:flutter_shared_preferences/login_screen.dart';
import 'package:flutter_shared_preferences/student_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'teacher_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLogIn() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;
    var userType = sp.getString('Type') ?? false;
    if (isLogin) {
      if (userType == 'Admin') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminScreen()));
      } else if (userType == 'Teacher') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TeacherScreen()));
      } else if (userType == 'Student') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StudentScreen()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LogInScreen()));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      isLogIn();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child:
                  Image.asset(height: 100, width: 100, 'assets/facebook.png'))
        ],
      ),
    );
  }
}
