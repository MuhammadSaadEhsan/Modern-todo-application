// ignore_for_file: unused_local_variable, invalid_return_type_for_catch_error, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/signIn.dart';
import 'package:mytodoapp/screens/signUp.dart';
import 'package:mytodoapp/screens/todoList.dart';

class AppServices {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  var fireAuthInstance = FirebaseAuth.instance;
  // String collectionName = Singup.nameController.text;

  Future searchNameWithId() async {
    String userId = fireAuthInstance.currentUser!.uid;
    CollectionReference users = firestoreInstance.collection('users');
    // print(userId);
    // print(users.where('userID', isEqualTo: userId));
    return await users.where('userID', isEqualTo: userId).get();

    // try {
    //   // Query the Firestore collection for the user with the provided user ID
    //   QuerySnapshot querySnapshot =
    //       await users.where('userID', isEqualTo: userId).get();

    //   // Check if any documents match the query
    //   if (querySnapshot.docs.isNotEmpty) {
    //     // Get the first document (assuming userId is unique)
    //     var userData = querySnapshot.docs.first.data();
    //     // Access the 'name' field from the user document
    //     // String userName = userData!['name'];
    //     // Return the user's name
    //     return userData;
    //   } else {
    //     // No user found with the provided user ID
    //     return null;
    //   }
    // } catch (error) {
    //   // Handle any errors that occur during the Firestore query
    //   print('Error searching for user: $error');
    //   return null;
    // }
  }

  addToDo(TextEditingController todoController,
      TextEditingController dateInput) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference todoList = firestoreInstance.collection('todo');
    await todoList.add({
      "todo": todoController.text.toString(),
      'timestamp': Timestamp.now(),
      'date': dateInput.text.toString(),
      'userID': userId,
      'isDone': false,
    });
  }

  addUserDetails() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = firestoreInstance.collection('users');
    await users.add({
      "name": Singup.nameController.text,
      'email': Singup.emailController.text,
      'userID': userId,
    });
  }

  // Future getdata() async {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;
  //   CollectionReference data = firestoreInstance.collection('todo');
  //   // return await data.orderBy('timestamp').get();
  //   return await data
  //       .where("userID", isEqualTo: userId)
  //       .orderBy("timestamp",descending: true)
  //       .get();
  // }
  Stream<QuerySnapshot> getData(String? name) async* {
    while (true) {
      try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference data = firestoreInstance.collection('todo');

    if (name != null && name.isNotEmpty) {
      QuerySnapshot querySnapshot = await data
          .where("userID", isEqualTo: userId)
          .where("todo", isGreaterThanOrEqualTo: name)
          .where("todo", isLessThanOrEqualTo: name + '\uf8ff')
          // .orderBy("timestamp", descending: true)
          .get();

      yield querySnapshot;
    } else {
      // Return all documents if no name is provided
      yield await data
          .where("userID", isEqualTo: userId)
          .orderBy("timestamp", descending: true)
          .get();
    }
  } catch (e) {
    print('Error getting data: $e');
    throw e; // Re-throw the error to handle it in the calling code if needed
  }
    }
  }

  Future<void> removeData(id, context) {
    CollectionReference todo = FirebaseFirestore.instance.collection('todo');
    return todo.doc(id.toString()).delete().then((value) {
      print("TODo Deleted");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text(
      //     'TODo Deleted',
      //     style: TextStyle(
      //       fontWeight: FontWeight.w600,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: Color.fromRGBO(85, 132, 122, 1),
      // ));
    }).catchError((error) => print("Failed to delete user: $error"));
  }

  signUp(context,
      {required emailController, required passwordController}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SingIn(),
          ));

      addUserDetails();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'The password provided is too weak.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(85, 132, 122, 1),
        ));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'The account already exists for that email.',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(85, 132, 122, 1),
        ));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signIn(context,
      {required emailController, required passwordController}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController, password: passwordController);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoList(),
          ));
      print("Successfully login");
    } catch (e) {
      print('Wrong Credentials, Try Again');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Wrong Credentials, Try Again',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(85, 132, 122, 1),
      ));
    }
  }

  signOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SingIn(),
        ));
  }

  Future<void> updateUser(docid, todoController, dateInputController) async {
    CollectionReference todo = FirebaseFirestore.instance.collection('todo');
    return await todo
        .doc(docid)
        .update({'todo': todoController.text, 'date': dateInputController.text})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> updateDone(docid, isDone) async {
    CollectionReference todo = FirebaseFirestore.instance.collection('todo');
    return await todo
        .doc(docid)
        .update({'isDone': isDone})
        .then((value) => print("isDone Updated"))
        .catchError((error) => print("Failed to update isDone: $error"));
  }
}
