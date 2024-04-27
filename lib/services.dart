// ignore_for_file: unused_local_variable, invalid_return_type_for_catch_error, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/screens/home.dart';
import 'package:mytodoapp/screens/signIn.dart';

class AppServices {
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  String collectionName = 'todo';

  addToDo() async {
    CollectionReference todoList = firestoreInstance.collection(collectionName);
    await todoList.add({"todo": Home.todoController.text.toString()});
  }

  Future getdata() async {
    CollectionReference data = firestoreInstance.collection(collectionName);
    return data.get();
  }

  Future<void> removeData(id, context) {
    CollectionReference todo =
        FirebaseFirestore.instance.collection(collectionName);
    return todo.doc(id.toString()).delete().then((value) {
      print("TODo Deleted");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'TODo Deleted',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(85, 132, 122, 1),
      ));
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
            builder: (context) => Home(),
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingIn(),
        ));
  }
}
