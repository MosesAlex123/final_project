import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter/material.dart';
import 'package:final_project/views/auth_gate.dart';

class CallBook extends StatefulWidget {
  const CallBook({Key? key}) : super(key: key);

  @override
  State<CallBook> createState() => _CallBookState();
}

class _CallBookState extends State<CallBook> {
  final _formkey = GlobalKey<FormState>();
  String? dropdown;
  var item = 0;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      onChanged: (value) {
        item = int.parse(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter item quantity';
        }
        if (!RegExp("^[0-9]").hasMatch(value)) {
          return ("Please Enter quantity as number");
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.shopping_basket_rounded),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Item",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text("Catalogue"),
          backgroundColor: Colors.blueGrey,
          elevation: 5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const AuthGate())));
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
                                child: DropdownButton<String>(
                                  value: dropdown,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.black),

                                  items: <String>[
                                    'quantity',
                                    'price',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "Please choose a field to update",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdown = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 45),
                              //firstNameField,
                              emailField,

                              const SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    updateValue(dropdown, item);
                                  },
                                  child: const Text('Update')),
                            ]))))));
  }

  void updateValue(String? field, int value) {
    FirebaseFirestore.instance
        .collection('Farmer products')
        .doc(field) // <-- Doc ID where data should be updated.
        .update({'quantity': value}) // <-- Updated data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }
}

class Book extends StatefulWidget {
  const Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  final _formkey = GlobalKey<FormState>();
  var item = 0;
  String? dropdown;
  final productQuery =
      FirebaseFirestore.instance.collection('Farmer products').orderBy('name');
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      onChanged: (value) {
        item = int.parse(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter item quantity';
        }
        if (!RegExp("^[0-9]").hasMatch(value)) {
          return ("Please Enter quantity as number");
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.shopping_basket_rounded),
          contentPadding: const EdgeInsets.fromLTRB(5, 3, 5, 13),
          hintText: "Item",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uploaded Products"),
        backgroundColor: Colors.blueGrey,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const AuthGate())));
          },
        ),
      ),
      body: SafeArea(
        //child: Column(
        //children: [
        child: FirestoreQueryBuilder(
          query: productQuery,
          builder: (context, snapshot, _) {
            if (snapshot.isFetching) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            }

            return ListView.builder(
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                // if we reached the end of the currently obtained items, we try to
                // obtain more items
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  // Tell FirestoreQueryBuilder to try to obtain more items.
                  // It is safe to call this function from within the build method.
                  snapshot.fetchMore();
                }

                final prod = snapshot.docs[index];

                if (prod['uploaderId'] ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Column(children: <Widget>[
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text('${prod['name']}'),
                                ),
                                Expanded(
                                  child: Text('Price: ${prod['price']}'),
                                ),
                                Expanded(
                                  child: Text('Qty: ${prod['quantity']}'),
                                ),
                                Expanded(
                                  child: Text('${prod['uploaderEmail']}'),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showBanner(context, '${prod['docId']}',
                                        '${prod['name']}');
                                  },
                                  icon: const Icon(Icons.delete_forever_sharp),
                                ),
                              ]),
                        ),

                        SizedBox(
                          height: 10,
                          child: DropdownButton<String>(
                            value: dropdown,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),

                            items: <String>[
                              'quantity',
                              'price',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: const Text(
                              "Please choose a field to update",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onChanged: (value) {
                              setState(() {
                                dropdown = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 5, height: 5),
                        //firstNameField,
                        emailField,
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Farmer products')
                                  .doc(prod[
                                      'docId']) // <-- Doc ID where data should be updated.
                                  .update({dropdown!: item}) // <-- Updated data
                                  .then((_) => print('Updated'))
                                  .catchError((error) =>
                                      print('Update failed: $error'));
                              //updateValue(dropdown, item);
                            },
                            child: const Text('Update')),
                      ]));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
          //child: Center(

          //),
        ),
        /** 
          Center(
            child: Container(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButton<String>(
                value: dropdown,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>[
                  'Android',
                  'IOS',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text(
                  "Please choose a langauage",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (value) {
                  setState(() {
                    dropdown = value;
                  });
                },
              ),
            ),
          )*/

        /**  ElevatedButton(
            onPressed: () {},
            child: Text('Go to Cart'),
          ),
        ],
      )*/
      ),
    );
  }

  void showBanner(BuildContext context, String id, String name) =>
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          backgroundColor: Color.fromARGB(0, 53, 18, 18),
          padding: const EdgeInsets.all(18),
          content: const Text('Are you sure you want to delete booking?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                FirebaseFirestore.instance
                    .collection('Farmer products')
                    .doc(id)
                    .delete()
                    .then(
                      (doc) => print("Product: $name deleted"),
                      onError: (e) => print("Error updating document $e"),
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
