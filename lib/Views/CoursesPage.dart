import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/Views/AuthPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/CourseCard.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  void signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const AuthPage();
    },), (route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
          //value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down,size: 30, color: Colors.white,),
          underline: SizedBox(),
          onChanged: (String? newValue) {
            if(newValue =="Log Out"){
              signOut();
            }
          },
          items: <String>['Log Out']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
      ),
        )],
        title: const Text("Courses"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("usercourses").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.docs != null) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final _card = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CourseCard(courseName: _card.get("coursename"),),
                );
              },
            );
          }
          else{
            return const Center(child: Text("There is something wrong, or no courses"),);
          }
        },
      ),
    );
  }
}
