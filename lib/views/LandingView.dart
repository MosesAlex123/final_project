import 'package:flutter/material.dart';
import '/login_screen.dart';
import '/registration_screen.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  //var child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POULTRY BOOKING"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("lib/Auth/chicken-logo.png"),
              ),
              const SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: const Text("REGISTER"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationScreen()));
                  }),
              const SizedBox(
                height: 15,
              ),
              ActionChip(
                  label: const Text("LOGIN"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
