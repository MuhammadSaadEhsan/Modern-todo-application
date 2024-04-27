import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/signUp.dart';
import 'package:mytodoapp/widgets/elevatedbtn.dart';
import 'package:mytodoapp/widgets/greenBox.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Column(
        children: [
          design(),
          
          const SizedBox(height: 10),
          Center(child: Image.asset("assets/man.png", height: 220)),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Get things done with TODo",
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
                  "TODo: Streamline tasks, achieve goals, and stay organized effortlessly, maximizing your productivity every step of the way.",
                  style: TextStyle(
                      color: Color.fromARGB(255, 77, 77, 77),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          elevatedBtn("Get Started",onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Singup(),
                  ));
            })
        ],
      ),
    );
  }
}
