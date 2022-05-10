import 'package:flutter/material.dart';
import '../registration_screen.dart';
import '../views/Login/ConsumersLogin.dart';
import '../views/Login/FactoriesLogin.dart';
import '../views/Login/FarmersLogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final factoriesButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueGrey,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const FactoriesLogin(
                        title: 'Factories Login',
                      ))));
        },
        child: const Text(
          "Factories Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final farmersButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueGrey,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const FarmersLogin(
                        title: 'Farmers Login',
                      ))));
        },
        child: const Text(
          "Farmers Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final consumersButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueGrey,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => const ConsumersLogin(
                        title: 'Consumer Login',
                      ))));
        },
        child: const Text(
          "Consumer Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text("LOGIN DIRECTORY"),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
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
                    const Text("DON'T have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const RegistrationScreen())));
                      },
                      child: const Text(
                        "REGISTER",
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

  Widget backgroudImage() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Auth/cute-chicks.jpg'),

            /// change this to your  image directory
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
