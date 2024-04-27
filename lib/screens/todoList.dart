// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/home.dart';
import 'package:mytodoapp/screens/signUp.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/greenBox.dart';

class TodoList extends StatefulWidget {
  TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  AppServices myService = AppServices();

  TextEditingController emailController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 239),
      body: Column(
        children: [
          design(),
          Center(
            child: Text(
              "Welcome ${Singup.nameController.text}!",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Center(child: Image.asset("assets/man4.png", height: 200)),
          ),
          // const SizedBox(height: 5),
          // const SizedBox(
          //   height: 25,
          // ),
          const Padding(
            padding: EdgeInsets.only(right: 180, top: 10),
            child: Text(
              "TODo Tasks.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          Container(
            height: 300,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Shadow color
                  spreadRadius: 5, // Spread radius
                  blurRadius: 7, // Blur radius
                  offset: const Offset(0, 3), // Offset from the top-left corner
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Dairy Tasks.",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 146, 146, 146)),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          },
                          icon: Icon(Icons.add_circle))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    width: 250,
                    // color: Colors.red,
                    child: FutureBuilder(
                      future: myService.getdata(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No Data Available",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                // print(snapshot.data.docs[index].id);
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Text(
                                          "${snapshot.data!.docs[index]['todo']}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          myService.removeData(
                                              snapshot.data.docs[index].id,
                                              context);
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 206, 14, 0)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          //elevated button ================
          // elevatedBtn("Sign In", onPress: () {
          //   myService.signIn(context,
          //       emailController: emailController.text,
          //       passwordController: confirmController.text);
          // }),
          const SizedBox(
            height: 5,
          ),

          //row ================
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Text(
          //       "Don't have account?",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w400),
          //       textAlign: TextAlign.center,
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => Singup(),
          //             ));
          //       },
          //       child: const Text(
          //         "Sign Up",
          //         style: TextStyle(
          //             color: Color.fromRGBO(85, 132, 122, 1),
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
