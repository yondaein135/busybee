import 'package:busy_bee/screens/home/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:busy_bee/constants.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  Future<void> _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        String uid = userCredential.user!.uid;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfileScreen(userId: uid)),
        );
      } on FirebaseAuthException catch (e) {
        var message = 'An error occurred, please check your credentials!';
        if (e.message != null) {
          message = e.message!;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: appGradient, // Use the global gradient constant
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: offWhite),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username/Email',
                      labelStyle: TextStyle(color: offWhite),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: offWhite)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: offWhite)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => !value!.contains('@') ? 'Please enter a valid email' : null,
                    onSaved: (value) => _email = value!,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    obscureText: true,
                    validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters long' : null,
                    onSaved: (value) => _password = value!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: offWhite),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _trySubmitForm,
                   style: ElevatedButton.styleFrom(
                      primary: primaryBackgroundLight, // Use light green for primary color
                      onPrimary: primaryBackground, // Use deep green for text color
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
