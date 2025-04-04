import 'package:flutter/material.dart';
import 'package:ui_connect/pages/AddProfile.dart';
import 'package:ui_connect/pages/profile_page.dart';
import 'package:ui_connect/pages/signup.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  // Function to handle login
  void _login() async {
    setState(() {
      _errorMessage = ''; // Clear previous errors
      _isLoading = true;
    });

    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get the UID of the logged-in user
      String uid = userCredential.user!.uid;

      // Fetch the user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection("user").doc(uid).get();

      // Check if the user document exists and fetch the type field
      if (userDoc.exists) {
        bool initialLogin = userDoc['initialLogin'];

        // set isLoggedIn field in firebase true
        await _firestore.collection("user").doc(uid).update({
          "isLoggedIn": true,
        });

        if (initialLogin == true) {
          // initialLogin = null;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddProfileScreen()),
          );
        } else {
          // initialLogin = null;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'An error occurred: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height:
                      MediaQuery.of(context).size.height * 0.1), // Add space
              Image.asset(
                'assets/images/harithaimage.jpg',
                height: 200,
              ),
              SizedBox(height: 80),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 280,
                child: TextField(
                  controller: _emailController,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: 280,
                child: TextField(
                  controller: _passwordController,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              SizedBox(
                width: 280, // Increased width
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Sign In', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not registered yet?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child:
                        Text('Sign Up', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
