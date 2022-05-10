import 'package:flutter/material.dart';
import '../login_screen.dart';
import '../views/LandingView.dart';
import '../views/Register/ConsumersRegister.dart';
import '../views/Register/FactoriesRegister.dart';
import '../views/Register/FarmersRegister.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final factoriesButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black87,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const FactoriesRegister())));
        },
        child: const Text(
          "Factories Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    final farmersButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black87,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const FarmersRegister())));
        },
        child: const Text(
          "Farmers Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    final consumersButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black87,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const ConsumerRegister())));
        },
        child: const Text(
          "Consumer Register",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("REGISTRATION DIRECTORY"),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/Auth/day-olds.jpg'),
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
                  height: 250,
                  child: Image.asset(
                    "lib/Auth/chicken-logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                factoriesButton,
                const SizedBox(height: 45),
                farmersButton,
                const SizedBox(height: 45),
                consumersButton,
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const LoginScreen())));
                      },
                      child: const Text(
                        "Login",
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
        //)
      ),
    );
  }
}
