// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/todoList.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/elevatedbtn.dart';
import 'package:mytodoapp/widgets/greenBox.dart';
import 'package:mytodoapp/widgets/textfield.dart';

class Home extends StatelessWidget {
  Home({super.key});

  AppServices myService = AppServices();

  static TextEditingController todoController = TextEditingController();

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
            const SizedBox(height: 20),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Image.asset("assets/man3.png", height: 220),
            )),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "And what you want to do later on?",
              style: TextStyle(
                  color: Color.fromRGBO(85, 132, 122, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            myTextField(todoController, " Enter your New TODo"),
            // const SizedBox(height: 20),
            // myTextField(confirmController, " Confirm Password",obscure:true),
            const SizedBox(
              height: 35,
            ),

            //elevated button ================
            elevatedBtn("Add TODo", onPress: () {
              myService.addToDo();
              todoController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Your TODo Added Successfully',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(85, 132, 122, 1),
                ));
            }),
            const SizedBox(height: 10),
            elevatedBtn("Your TODo List", onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoList(),
                  ));
            }),
            const SizedBox(
              height: 5,
            ),

            //row ================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Want to",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    myService.signOut(context);
                  },
                  child: const Text(
                    "Sign Out?",
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
