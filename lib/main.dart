import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytodoapp/firebase_options.dart';
import 'package:mytodoapp/screens/getStarted.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
      // home: Singup(),
    );
  }
}
