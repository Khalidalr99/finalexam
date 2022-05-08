

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {

static Future<bool> register(String email, String password) async {

  try {
    //create user in firebase authentication
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);

    //store the user in the user collection
    await FirebaseFirestore.instance.collection("users").add({
      "email": email,
      "password": password,
      "createdAt": Timestamp.now()
    });
    return true;
  }
  catch(e){
    return false;
  }
}

}
