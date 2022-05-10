import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Auth/reusable_widget.dart';
import '/registration_screen.dart';
import '/views/Login/FactoriesLogin.dart';
import '/views/Profile/FactoriesProfile.dart';
import '/views/landingView.dart';

class FactoriesRegister extends StatefulWidget {
  const FactoriesRegister({Key? key, title}) : super(key: key);

  @override
  _FactoriesRegisterState createState() => _FactoriesRegisterState();
}

class _FactoriesRegisterState extends State<FactoriesRegister> {
  // string for displaying the error Message
  String? errorMessage;

  final _formkey = GlobalKey<FormState>();

  //editting controller
  final firstNameTextEditingController = TextEditingController();
  final businessNoEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference factory =
        FirebaseFirestore.instance.collection('factories');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("FACTORIES REGISTER"),
        backgroundColor: Colors.transparent,
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
          color: Colors.white,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    "lib/Auth/logo pic.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 25),
                //secondNameField,
                reusableTextField(
                    "Enter business number",
                    Icons.business_center_rounded,
                    false,
                    businessNoEditingController),
                const SizedBox(height: 45),
                //firstNameField,
                reusableTextField("Enter first Name", Icons.person_outline,
                    false, firstNameTextEditingController),
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
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    passwordEditingController),
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
                    factory.doc(value.user!.uid).set({
                          'businessNo': businessNoEditingController.text,
                          'name': firstNameTextEditingController.text,
                          'email': emailEditingController.text,
                          'phone': phoneNumberEditingController.text,
                          'physical address': addressEditingController.text,
                          'cart': [],
                        })
                        .then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FactoryNav())))
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
                                builder: ((context) => const FactoriesLogin(
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
