import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/booking/models/models.dart';
import 'package:final_project/views/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/registration_screen.dart';
import '/views/Login/FarmersLogin.dart';
import '/views/Profile/FarmersProfile.dart';

class FarmersRegister extends StatefulWidget {
  const FarmersRegister({Key? key, title}) : super(key: key);

  @override
  _FarmersRegisterState createState() => _FarmersRegisterState();
}

class _FarmersRegisterState extends State<FarmersRegister> {
  // string for displaying the error Message
  String? errorMessage;

  final _formkey = GlobalKey<FormState>();

  //editting controller
  final firstNameTextEditingController = TextEditingController();
  final omangEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference farmer =
        FirebaseFirestore.instance.collection('farmers');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("FARMERS REGISTER"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
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
                    reusableTextField("Enter Omang", Icons.person_outline,
                        false, omangEditingController),
                    const SizedBox(height: 45),
                    //firstNameField,
                    reusableTextField("Enter first Name", Icons.person_outline,
                        false, firstNameTextEditingController),
                    const SizedBox(height: 25),
                    //secondNameField,
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
                    reusableTextField(
                        "Enter Physical Address",
                        Icons.location_city_rounded,
                        false,
                        addressEditingController),
                    //passswordField,
                    const SizedBox(height: 25),
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
                        if (kDebugMode) {
                          print("Created New Account");
                        }
                        farmer
                            .doc(value.user!.uid)
                            .set(Farmer(
                                    omang: omangEditingController.text,
                                    name: firstNameTextEditingController.text,
                                    email: emailEditingController.text,
                                    phoneNumber:
                                        phoneNumberEditingController.text,
                                    physicalAddress:
                                        addressEditingController.text)
                                .toJson())
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FarmerNav())))
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
                                    builder: ((context) => const FarmersLogin(
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
