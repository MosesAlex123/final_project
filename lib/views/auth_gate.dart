import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import 'Home/Home.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? currentUserType;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser!.uid.isNotEmpty) {
      getCurrentUserType();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (currentUserType == "Farmer")
              ? const FarmerNav()
              : (currentUserType == "Consumer")
                  ? const ConsumerNav()
                  : (currentUserType == "Factory")
                      ? const FactoryNav()
                      : (currentUserType == null)
                          ? const LoginScreen()
                          : const LoginScreen();
        } else {
          return (currentUserType == null)
              ? const AuthGate()
              : const LoginScreen();
        }
      },
    );
  }

  void getCurrentUserType() {
    FirebaseFirestore.instance
        .collection('farmers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        if (kDebugMode) {
          print("You're a farmer");
        }
        setState(() {
          currentUserType = "Farmer";
        });
      } else {
        FirebaseFirestore.instance
            .collection('factories')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            if (kDebugMode) {
              print("You're a factory");
            }
            setState(() {
              currentUserType = "Factory";
            });
          } else {
            if (kDebugMode) {
              print("You're a consumer");
            }
            setState(() {
              currentUserType = "Consumer";
            });
          }
        });
      }
    });
  }
}
