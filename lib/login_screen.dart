import 'package:flutter/material.dart';
import 'package:flutter_shared_preferences/admin_screen.dart';
import 'package:flutter_shared_preferences/home_screen.dart';
import 'package:flutter_shared_preferences/student_screen.dart';
import 'package:flutter_shared_preferences/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String dropDownValue = 'Admin';
  List<String> dropDownList = ['Admin', 'Teacher', 'Student'];

  String userType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.password_outlined),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Age',
                  prefixIcon: const Icon(Icons.account_box),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade300),
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            // I want to store users in sahred preferences
            // in dropdown button. For example when i select user(i.e Admin from dropdown), so it navigate
            // to Admin Screen.
            DropdownButton(
                value: dropDownValue,
                items:
                    dropDownList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? newValue) async {
                  setState(() {
                    dropDownValue = newValue!;
                    print(newValue.toString());
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('Email', emailController.text.toString());
                sp.setString('Name', nameController.text.toString());
                sp.setString('Age', ageController.text.toString());
                sp.setString('Type', 'Admin');
                sp.setBool('isLogin', true);
                if (sp.getString('Type') == 'Admin') {
                  print('Admin fnc');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminScreen()));
                } else if (sp.getString('Type') == 'Teacher') {
                  print('Teacher fnc');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeacherScreen()));
                } else if (sp.getString('Type') == 'Student') {
                  print('Student fnc');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentScreen()));
                } else {
                  print('condition not matched');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('LogIn')),
              ),
            )
          ],
        ),
      )),
    );
  }
}
