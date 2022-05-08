import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/Views/AuthPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future appLoading() async{
    
    await Firebase.initializeApp();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AuthPage(),), (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    appLoading();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
