import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/booking/forms/items.dart';
import 'package:final_project/booking/models/factory.dart';
import 'package:final_project/catalogue/screens/catalog_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../booking/forms/records.dart';
import '/views/Login/FactoriesLogin.dart';
import 'package:flutter/material.dart';

class FactoriesProfile extends StatefulWidget {
  const FactoriesProfile({Key? key}) : super(key: key);

  @override
  _FactoriesProfileState createState() => _FactoriesProfileState();
}

class _FactoriesProfileState extends State<FactoriesProfile> {
  final Stream<QuerySnapshot> factory =
      FirebaseFirestore.instance.collection('factory').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("FACTORY PROFILE"),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            ListTile(
              hoverColor: Colors.blueGrey,
              selectedColor: Colors.blue,
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const FactoryProfilePage())));
              },
            ),
            ListTile(
              hoverColor: Colors.blueGrey,
              selectedColor: Colors.blue,
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  showBanner();
                  Navigator.pop(context);
                });
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Log out"),
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          backgroudImage(),
          Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Flexible(
                child: GridView.count(
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(20),
                    mainAxisSpacing: 10,
                    primary: false,
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const ItemEntryForm())));
                            },
                            child: Card(
                                color: Colors.green,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child:
                                            Image.asset('lib/Auth/booking.png'),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            child: const Text('Enter Product'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.purple,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const ItemEntryForm())));
                                            }),
                                      ),
                                    ])),
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const CatalogScreen(
                                              entryPoint: 'Factory'))));
                            },
                            child: Card(
                                color: Colors.green,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child: Image.asset(
                                            'lib/Auth/day-olds.jpg'),
                                      ),
                                      Expanded(
                                        child: TextButton(
                                            child: const Text('View Catalogue'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.purple,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const CatalogScreen(
                                                              entryPoint:
                                                                  'Factory'))));
                                            }),
                                      )
                                    ])),
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              /**Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const FactoryReports()
                                          )));*/
                            },
                            child: Card(
                                color: Colors.green,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child:
                                            Image.asset('lib/Auth/report.jpg'),
                                      ),
                                      Expanded(
                                          child: TextButton(
                                              child: const Text('Reports'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.purple,
                                              ),
                                              onPressed: () {
                                                /**Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            const FactoryReports())));*/
                                              })),
                                    ])),
                          )),
                      Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid))));
                            },
                            child: Card(
                                color: Colors.green,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child: Image.asset(
                                            'lib/Auth/Settings.png'),
                                      ),
                                      Expanded(
                                          child: TextButton(
                                              child: const Text('Settings'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.purple,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid))));
                                              })),
                                    ])),
                          )),
                    ],
                    crossAxisCount: 2),
              )
            ],
          )
        ],
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

  void showBanner() =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FactoriesLogin(
                              title: '',
                            )));
              },
              child: const Text('YES'),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: const Text('NO'))
          ]));
}

class FactoryProfilePage extends StatefulWidget {
  const FactoryProfilePage({Key? key}) : super(key: key);

  @override
  State<FactoryProfilePage> createState() => _FactoryProfilePageState();
}

class _FactoryProfilePageState extends State<FactoryProfilePage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('factories');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Factory> getProfileInfo() async {
    return await users
        .doc(_auth.currentUser!.uid)
        .withConverter<Factory>(
          fromFirestore: (snapshots, _) => Factory.fromJson(snapshots.data()!),
          toFirestore: (Factory, _) => Factory.toJson(),
        )
        .get()
        .then((value) {
      return Factory.fromJson(value.data()!.toJson());
    });
  }

  Future<String?> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.email;
  }
}
