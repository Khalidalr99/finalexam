import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.courseName}) : super(key: key);
  final String courseName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      
      child: Center(child: Text(courseName)),
      height: 150,
    );
  }
}
