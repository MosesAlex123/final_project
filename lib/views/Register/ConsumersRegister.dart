import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/registration_screen.dart';
import '/views/Login/ConsumersLogin.dart';
import '/views/Profile/ConsumersProfile.dart';
import '/views/landingView.dart';

class ConsumerRegister extends StatefulWidget {
  const ConsumerRegister({Key? key, title}) : super(key: key);

  @override
  _ConsumerRegisterState createState() => _ConsumerRegisterState();
}

class _ConsumerRegisterState extends State<ConsumerRegister> {
  // string for displaying the error Message
  String? errorMessage;

  final _formkey = GlobalKey<FormState>();

  //editting controller
  final omangTextEditingController = TextEditingController();
  final firstNameTextEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference consumer =
        FirebaseFirestore.instance.collection('consumers');

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text("CONSUMERS REGISTER"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const RegistrationScreen())));
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
          child: SingleChildScrollView(
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
                    //firstNameField,
                    reusableTextField("Enter first Name", Icons.person_outline,
                        false, firstNameTextEditingController),
                    const SizedBox(height: 25),
                    //secondNameField,
                    reusableTextField("Enter Omang", Icons.person_outline,
                        false, omangTextEditingController),
                    const SizedBox(height: 25),
                    //emailField,
                    reusableTextField("Enter Email", Icons.mail_outline_rounded,
                        false, emailEditingController),
                    const SizedBox(height: 25),
                    //phoneNumberField,
                    reusableTextField(
                        "Enter phone Number",
                        Icons.add_ic_call_rounded,
                        false,
                        phoneNumberEditingController),
                    const SizedBox(height: 25),
                    //emailField,
                    reusableTextField(
                        "Enter Physical Address",
                        Icons.location_city_rounded,
                        false,
                        addressEditingController),
                    const SizedBox(height: 25),
                    //passswordField,
                    reusableTextField("Enter Password", Icons.lock_outlined,
                        true, passwordEditingController),
                    //const SizedBox(height: 25),
                    //confirmpassswordField,
                    const SizedBox(height: 35),
                    //signUpButton,
                    firebaseUIButton(context, "Sign Up", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailEditingController.text,
                              password: passwordEditingController.text)
                          .then((value) {
                        print("Created New Account");
                        consumer
                            .doc(value.user!.uid)
                            .set({
                              'omang': omangTextEditingController.text,
                              'name': firstNameTextEditingController.text,
                              'email': emailEditingController.text,
                              'phone': phoneNumberEditingController.text,
                              'physical address': addressEditingController.text,
                            })
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ConsumerNav())))
                            .catchError(
                                (error) => print('Failed to add User: $error'));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    }),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const ConsumersLogin(
                                          title: 'LOGIN',
                                        ))));
                          },
                          child: const Text(
                            "Login",
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
          )),
    );
  }
}
