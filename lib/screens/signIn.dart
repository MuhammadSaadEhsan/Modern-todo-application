// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/signUp.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/elevatedbtn.dart';
import 'package:mytodoapp/widgets/greenBox.dart';
import 'package:mytodoapp/widgets/textfield.dart';

class SingIn extends StatelessWidget {
  SingIn({super.key});

  AppServices myService = AppServices();

  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            design(),
            // const SizedBox(height: 10),
            const Center(
              child: Text(
                "Welcome Back!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 10),
            Center(child: Image.asset("assets/man2.png", height: 220)),
            // const SizedBox(height: 5),
            myTextField(emailController, " Enter your Email address"),
            const SizedBox(height: 20),
            myTextField(confirmController, " Confirm Password",obscure:true),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Forgot password ?",
              style: TextStyle(
                  color: Color.fromRGBO(85, 132, 122, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
        
            //elevated button ================
            elevatedBtn("Sign In", onPress: () {
              myService.signIn(context,
                  emailController: emailController.text,
                  passwordController: confirmController.text);
            }),
            const SizedBox(
              height: 5,
            ),
        
            //row ================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have account?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Singup(),
                        ));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Color.fromRGBO(85, 132, 122, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
