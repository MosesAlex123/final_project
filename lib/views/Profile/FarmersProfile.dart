import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/booking/forms/book.dart';
import 'package:final_project/booking/forms/items.dart';
import 'package:final_project/booking/forms/records.dart';
import 'package:final_project/booking/models/farmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../catalogue/screens/catalog_screen.dart';
import '/views/Login/FarmersLogin.dart';

class FarmersProfile extends StatefulWidget {
  const FarmersProfile({Key? key}) : super(key: key);

  @override
  _FarmersProfileState createState() => _FarmersProfileState();
}

class _FarmersProfileState extends State<FarmersProfile> {
  final Stream<QuerySnapshot> farmer =
      FirebaseFirestore.instance.collection('farmers').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        iconTheme: const IconThemeData(color: Colors.green),
        title: const Text("FARMER PROFILE"),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: ListView(
          children: [
            ListTile(
              //tileColor: Colors.green,
              hoverColor: Colors.blueGrey,
              selectedColor: Colors.blue,
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const FarmerProfilePage())));
              },
            ),
            ListTile(
              //tileColor: Colors.green,
              hoverColor: Colors.blueGrey,
              selectedColor: Colors.blue,
              onTap: () {
                showBanner();
                Navigator.pop(context);
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
                                          const FarmerEntry())));
                            },
                            child: Card(
                                color: Colors.amber,
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
                                            child: const Text('Upload Slots'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.black,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const FarmerEntry())));
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
                                              entryPoint: 'Farmer'))));
                            },
                            child: Card(
                                color: Colors.blueAccent,
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
                                              primary: Colors.black,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          const CatalogScreen(
                                                            entryPoint:
                                                                'Farmer',
                                                          ))));
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
                                      builder: ((context) => RecordScreen(
                                            entryPoint: FirebaseAuth
                                                .instance.currentUser!.uid,
                                          ))));
                            },
                            child: Card(
                                color: Colors.blueGrey,
                                elevation: 2,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 48.0,
                                        child: Image.asset(
                                            'lib/Auth/chicken2.png'),
                                      ),
                                      Expanded(
                                          child: TextButton(
                                              child: const Text('Records'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.black, 
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            RecordScreen(
                                                              entryPoint:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                            ))));
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
                                      builder: ((context) => RecordPS(
                                            entryPoint: FirebaseAuth
                                                .instance.currentUser!.uid,
                                          ))));
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
                                              child: const Text('Booked'),
                                              style: TextButton.styleFrom(
                                                primary: Colors.black,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            RecordPS(
                                                              entryPoint:
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid,
                                                            ))));
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
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                FirebaseAuth.instance.signOut().then(
                  (value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FarmersLogin(
                                  title: '',
                                )));
                  },
                );
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

class FarmerProfilePage extends StatefulWidget {
  const FarmerProfilePage({Key? key}) : super(key: key);

  @override
  State<FarmerProfilePage> createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('farmers');
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

  Future<Farmer> getProfileInfo() async {
    return await users
        .doc(_auth.currentUser!.uid)
        .withConverter<Farmer>(
          fromFirestore: (snapshots, _) => Farmer.fromJson(snapshots.data()!),
          toFirestore: (Farmer, _) => Farmer.toJson(),
        )
        .get()
        .then((value) {
      return Farmer.fromJson(value.data()!.toJson());
    });
  }

  Future<String?> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.email;
  }
}
