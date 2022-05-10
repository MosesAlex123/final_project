import 'package:final_project/views/Home/Home.dart';
import 'package:final_project/views/Login/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/views/LandingView.dart';
import '/views/Profile/FactoriesProfile.dart';
import '/views/Register/FactoriesRegister.dart';
import '/login_screen.dart';

class FactoriesLogin extends StatefulWidget {
  const FactoriesLogin({Key? key, required String title}) : super(key: key);

  @override
  _FactoriesLoginState createState() => _FactoriesLoginState();
}

class _FactoriesLoginState extends State<FactoriesLogin> {
  //editting controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //form key
  final _formkey = GlobalKey<FormState>();

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("FACTORIES LOGIN"),
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
                            builder: (context) => const FactoryNav()));
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
                                    const FactoriesRegister())));
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

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FactoriesRegister()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
        )
      ],
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
