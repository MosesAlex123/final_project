import 'package:final_project/views/Home/Home.dart';
import 'package:final_project/views/Login/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/login_screen.dart';
import '/views/LandingView.dart';
import '/views/Profile/FarmersProfile.dart';
import '/views/Register/FarmersRegister.dart';

class FarmersLogin extends StatefulWidget {
  const FarmersLogin({Key? key, required String title}) : super(key: key);
  @override
  _FarmersLoginState createState() => _FarmersLoginState();
}

class _FarmersLoginState extends State<FarmersLogin> {
  //editting controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //form key
  final _formkey = GlobalKey<FormState>();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("FARMERS LOGIN"),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const LoginScreen())));
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/Auth/cute-chicks.jpg'),
                //fit: BoxFit.cover
                fit: BoxFit.cover),
          ),
          //child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      "lib/Auth/chicken-logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 45),
                  reusableTextField("Enter Email", Icons.mail_outline_rounded,
                      false, emailController),
                  const SizedBox(height: 25),
                  //passwordField,
                  reusableTextField("Enter Password", Icons.lock_outlined, true,
                      passwordController),
                  const SizedBox(height: 35),
                  //loginButton,
                  forgetPassword(context),
                  firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FarmerNav()));
                    }).onError((error, stackTrace) {
                      if (kDebugMode) {
                        print("Error ${error.toString()}");
                      }
                    });
                  }),

                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const FarmersRegister())));
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        //),
        );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
