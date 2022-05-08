import 'package:email_validator/email_validator.dart';
import 'package:finalexam/Controller/AuthController.dart';
import 'package:finalexam/Views/CoursesPage.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  Future register() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    if (await AuthController.register(email, password)) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const CoursesPage();
        },
      ), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          'Email is already exist',
          style: TextStyle(color: Colors.red),
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height / 3,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !EmailValidator.validate(value)) {
                          return 'Please Enter Valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Password must be at least 8 chars long';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.withOpacity(0.1), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        register();
                      }
                    },
                    child: const Text('SignUp'),
                  ),
                  // Add TextFormFields and ElevatedButton here.
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
