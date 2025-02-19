import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yipfree_admin/views/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
  options: kIsWeb || Platform.isAndroid ? const FirebaseOptions(
    apiKey: "AIzaSyBZWR2VzPZYgmhIWL_DtQgplsLvP56BbYk",
    appId: "1:13148124239:web:d0b9daffea60cdb003263a",
    messagingSenderId: "13148124239",
    projectId: "yipfree-marketplace",
    authDomain: "yipfree-marketplace.firebaseapp.com",
    storageBucket: "yipfree-marketplace.firebasestorage.app",
    measurementId: "G-93VVWN51FN") : null,
);

  try {
    // Test Firestore connection
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('test').doc('test').get();
    print('Firebase Cloud Firestore initialized successfully');
  } catch (e) {
    print('Error initializing Firebase Cloud Firestore: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YipFree Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}
