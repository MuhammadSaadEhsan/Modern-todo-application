// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytodoapp/services.dart';
import 'package:mytodoapp/widgets/elevatedbtn.dart';
import 'package:mytodoapp/widgets/greenBox.dart';
import 'package:mytodoapp/widgets/textField.dart';
import 'package:mytodoapp/widgets/textdesign.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  AppServices myService = AppServices();
  String name = '';
  Icon icon1 = const Icon(
    Icons.check_box_outline_blank,
    color: Colors.white,
  );
  Icon icon2 = const Icon(
    Icons.check_box,
    color: Colors.white,
  );
  bool isDone = false;
  static TextEditingController todoController = TextEditingController();
  static TextEditingController searchController = TextEditingController();
  static TextEditingController dateInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myService = AppServices();
    fetchName();
  }

  Future<void> fetchName() async {
    final value = await myService.searchNameWithId();
    setState(() {
      name = value.docs[0]['name'] ?? '';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/man4.png", height: 150),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textdesign("What's"),
                      textdesign("On"),
                      textdesign("Your"),
                      textdesign("Mind"),
                      textdesign('$name?'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 17),
            const Padding(
              padding: EdgeInsets.only(right: 180, top: 0),
              child: Text(
                "TODo Tasks.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            Container(
              height: 372,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset:
                        const Offset(0, 3), // Offset from the top-left corner
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 170,
                            child: myTextField(searchController, "Search here",
                                paddingh: 0,
                                paddingv: 5,
                                coloring: Color.fromARGB(255, 207, 206, 206),
                                submit:
                                    myService.getData(searchController.text),
                                onChange: (val) {
                              setState(() {
                                // name = val;
                                myService.getData(searchController.text);
                              });
                            }, searchIcon: '\u{1F50D}')),
                        IconButton(
                            onPressed: () {
                              showDlg(todoController, dateInputController,
                                  "Add", submit);
                            },
                            icon: const Icon(Icons.add_circle))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      height: 270,
                      width: 340,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: StreamBuilder(
                          stream: myService.getData(searchController.text),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: Color.fromRGBO(85, 132, 122, 60),
                              ));
                            } else if (snapshot.hasData == false) {
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
                                    isDone =
                                        snapshot.data.docs[index]['isDone'];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      decoration: BoxDecoration(
                                          // color: const Color.fromARGB(255, 239, 239, 239),
                                          color: const Color.fromARGB(
                                              255, 95, 146, 135),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                          leading: IconButton(
                                              onPressed: () {
                                                isDone = snapshot
                                                    .data.docs[index]['isDone'];
                                                var docid = snapshot
                                                    .data.docs[index].id
                                                    .toString();

                                                // setState(() {
                                                isDone = !isDone;
                                                // });
                                                myService.updateDone(
                                                    docid, isDone);
                                              },
                                              icon: isDone ? icon2 : icon1),
                                          title: Text(
                                            "${snapshot.data!.docs[index]['todo']}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            "${snapshot.data!.docs[index]['date'] ?? ''}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  var docid = snapshot
                                                      .data.docs[index].id
                                                      .toString();
                                                  todoController.text = snapshot
                                                      .data.docs[index]['todo'];
                                                  dateInputController.text =
                                                      snapshot.data.docs[index]
                                                          ['date'];
                                                  showDlg(
                                                      todoController,
                                                      dateInputController,
                                                      "Update",
                                                      updated,
                                                      docid: docid,
                                                      isUpdated: true);
                                                  // myService.updateUser;
                                                },
                                                icon: const Icon(Icons.edit,
                                                    color: Colors.white),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  myService.removeData(
                                                      snapshot
                                                          .data.docs[index].id,
                                                      context);
                                                  // setState(() {});
                                                },
                                                icon: const Icon(Icons.delete,
                                                    color: Color.fromARGB(
                                                        255, 255, 0, 0)),
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

  submit() {
    myService.addToDo(todoController, dateInputController);
    setState(() {});
    todoController.clear();
    dateInputController.clear();
    Navigator.of(context).pop();
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text(
    //     'Your TODo Added Successfully',
    //     style: TextStyle(
    //       fontWeight: FontWeight.w600,
    //       color: Colors.white,
    //     ),
    //   ),
    //   backgroundColor: Color.fromRGBO(85, 132, 122, 1),
    // ));
  }

  updated(docid) {
    myService.updateUser(docid, todoController, dateInputController);
    // setState(() {});
    todoController.clear();
    dateInputController.clear();
    Navigator.of(context).pop();
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text(
    //     'Your TODo Updated Successfully',
    //     style: TextStyle(
    //       fontWeight: FontWeight.w600,
    //       color: Colors.white,
    //     ),
    //   ),
    //   backgroundColor: Color.fromRGBO(85, 132, 122, 1),
    // ));
  }

  showDlg(todoController, dateInputController, btn, func,
      {String? docid, isUpdated = false}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
            backgroundColor: const Color.fromARGB(255, 212, 236, 228),
            title: textdesign("Your TODo"),
            content: myTextField(todoController, "Enter your new TODo",
                paddingh: 0.0, submit: func, focusing: true),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          dateInputController.text = formattedDate;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Color.fromRGBO(85, 132, 122, 1),
                      size: 40,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: myTextField(
                        dateInputController,
                        "Date : dd-MM-yyyy",
                        paddingh: 0,
                        submit: submit,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              elevatedBtn(btn,
                  // widthinput: 40.000,
                  onPress: () {
                (isUpdated == true) ? func(docid) : func();
                // func();
              })
            ],
          );
        });
  }
}
