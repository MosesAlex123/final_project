import 'package:final_project/views/Home/Home.dart';
import 'package:final_project/views/Login/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/views/LandingView.dart';
import '/views/Profile/ConsumersProfile.dart';
import '/views/Register/ConsumersRegister.dart';
import '/login_screen.dart';

class ConsumersLogin extends StatefulWidget {
  const ConsumersLogin({Key? key, required String title}) : super(key: key);

  @override
  _ConsumersLoginState createState() => _ConsumersLoginState();
}

class _ConsumersLoginState extends State<ConsumersLogin> {
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
        title: const Text("CONSUMERS LOGIN"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const LoginScreen())));
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
                //emailField,
                reusableTextField("Enter Email", Icons.mail_outline_rounded,
                    false, emailController),
                const SizedBox(height: 25),
                //passwordField,
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    passwordController),
                const SizedBox(height: 25),
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConsumerNav()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
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
                                    const ConsumerRegister())));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            color: Colors.redAccent,
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
        //)
      ),
    );
  }
}
