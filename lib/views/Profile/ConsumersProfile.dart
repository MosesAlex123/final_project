import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/booking/forms/book.dart';
import 'package:final_project/catalogue/screens/catalog_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../booking/forms/items.dart';
import '../../booking/forms/records.dart';
import '../../booking/models/consumer.dart';
import '/views/Login/ConsumersLogin.dart';

class ConsumerProfile extends StatefulWidget {
  const ConsumerProfile({Key? key}) : super(key: key);

  @override
  _ConsumerProfileState createState() => _ConsumerProfileState();
}

class _ConsumerProfileState extends State<ConsumerProfile> {
  final Stream<QuerySnapshot> consumer =
      FirebaseFirestore.instance.collection('consumer').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("CONSUMER PROFILE"),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ProfilePage())));
              },
            ),
            
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  showBanner();
                  Navigator.pop(context);
                });
              },
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Log out"),
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
                                          const ConsumerCatalog(entryPoint: 'Consumer',))));
                            },
                            child: Card(
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
                                            child: const Text('Booking'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.purple,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const ConsumerCatalog(entryPoint: 'Consumer',))));
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
                                          SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid,))));
                            },
                            child: Card(
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child: Image.asset(
                                            'lib/Auth/settings.png'),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid))));
                            },
                            child: Card(
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child: Image.asset(
                                            'lib/Auth/chicken1.png'),
                                      ),
                                      Expanded(
                                          child: TextButton(
                                              child: const Text('Saved'),
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
                                           RecordP(entrypoint: FirebaseAuth.instance.currentUser!.uid,))));
                            },
                            child: Card(
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            RecordP(entrypoint: FirebaseAuth.instance.currentUser!.uid,))));
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
                        builder: (context) => const ConsumersLogin(
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('consumers');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getProfileInfo(),
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

  Future<Consumer> getProfileInfo() async {
    return await users
        .doc(_auth.currentUser!.uid)
        .withConverter<Consumer>(
          fromFirestore: (snapshots, _) => Consumer.fromJson(snapshots.data()!),
          toFirestore: (Consumer, _) => Consumer.toJson(),
        )
        .get()
        .then((value) {
      return Consumer.fromJson(value.data()!.toJson());
    });
  }

  Future<String?> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.email;
  }
}
