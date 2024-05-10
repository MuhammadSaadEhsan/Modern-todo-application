// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/getStarted.dart';
import 'package:mytodoapp/screens/todoList.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/greenBox.dart';

class Splash extends StatefulWidget {
  Splash({super.key});

  // static TextEditingController todoController = TextEditingController();

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AppServices myService = AppServices();

  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
    // Simulate a delay before navigating to the next screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                isLogin ? const TodoList() : const GetStarted()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            design(),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Welcome to Saad's TODo App! 😍",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 20),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Image.asset("assets/man3.png", height: 220),
            )),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Your TODo of the day :",
              style: TextStyle(
                  color: Color.fromRGBO(85, 132, 122, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // myTextField(todoController, " Enter your New TODo"),
            Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: const Center(
                  child: Text(
                "Keep doing Good Work 💚",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              )),
            ),
            // const SizedBox(height: 20),
            // myTextField(confirmController, " Confirm Password",obscure:true),
            const SizedBox(
              height: 52,
            ),

            //elevated button ================
            // elevatedBtn("Add TODo", onPress: () {
            //   myService.addToDo();
            //   Splash.todoController.clear();
            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //     content: Text(
            //       'Your TODo Added Successfully',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //     backgroundColor: Color.fromRGBO(85, 132, 122, 1),
            //   ));
            // }),
            // const SizedBox(height: 10),
            // elevatedBtn("Your TODo List", onPress: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => TodoList(),
            //       ));
            // }),

            design2()
          ],
        ),
      ),
    );
  }
}
