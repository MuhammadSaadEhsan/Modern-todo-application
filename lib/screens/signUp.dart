// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/signIn.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/elevatedbtn.dart';
import 'package:mytodoapp/widgets/greenBox.dart';
import 'package:mytodoapp/widgets/textfield.dart';

class Singup extends StatelessWidget {
  Singup({super.key});

  AppServices myServices = AppServices();

  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            design(),
            const SizedBox(height: 25),
            const Center(
              child: Text(
                "Welcome Onboard!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Lets helps you meet up your task",
                    style: TextStyle(
                        color: Color.fromRGBO(85, 132, 122, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            myTextField(nameController, " Enter your Name"),
            const SizedBox(height: 20),
            myTextField(emailController, " Enter your Email address"),
            const SizedBox(
              height: 20,
            ),
            myTextField(passwordController, " Create a Password",
                obscure: true),
            const SizedBox(
              height: 20,
            ),
            myTextField(confirmController, " Confirm your Password",
                obscure: true),
            const SizedBox(
              height: 40,
            ),

            //elevated button ====================
            elevatedBtn("Sign Up", onPress: () {
              if (passwordController.text == confirmController.text && nameController.text.isNotEmpty && nameController.text.length<9) {
                myServices.signUp(context,
                    emailController: emailController.text,
                    passwordController: passwordController.text);
              } 
              else if(nameController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Please provide your name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(85, 132, 122, 1),
                ));
              }
              else if(nameController.text.length>10){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Please write your short name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(85, 132, 122, 1),
                ));
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'You have done a mistake in Password or Confirm Password, Try Again',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(85, 132, 122, 1),
                ));
              }
            }),
            const SizedBox(
              height: 5,
            ),

            //row =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
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
                          builder: (context) => SingIn(),
                        ));
                  },
                  child: const Text(
                    "Sign In",
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
