import 'dart:async'; // new
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/views/Home/Home.dart';
import 'package:final_project/views/auth_gate.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemEntryForm extends StatefulWidget {
  const ItemEntryForm({Key? key}) : super(key: key);

  @override
  State<ItemEntryForm> createState() => _ItemEntryFormState();
}

class _ItemEntryFormState extends State<ItemEntryForm> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String? dropdown;
  DateTime date = DateTime.now();

  var name = '';
  var quantity = 0;
  var price = 0.0;
  var url = '';
  //var date = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Products To Sell"),
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
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /**TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Item name',
                  labelText: 'Name',
                ),
                onChanged: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter item name';
                  }
                },
              ),*/
              SizedBox(
                height: 10,
                child: DropdownButton<String>(
                  value: dropdown,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>[
                    'Chickens',
                    'Dintshu/Gizzards',
                    'Dibete/Livers',
                    'Melala/Necks',
                    'Menoto/Feets',
                    'Mala/Intestines',
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
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Item Quantity',
                  labelText: 'Quantity',
                ),
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter item quantity';
                  }
                  if (!RegExp("^[0-9]").hasMatch(value)) {
                    return ("Please Enter quantity as number");
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Item price',
                  labelText: 'Price',
                ),
                onChanged: (value) {
                  price = double.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Price';
                  }
                  if (!RegExp("^[0-9]").hasMatch(value)) {
                    return ("Please Enter price as number");
                  }
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              dense: false,
                              leading: Image.network(image['url']),
                              title: Text(image['uploaded_by']),
                              subtitle: Text(image['description']),
                              trailing: IconButton(
                                onPressed: () => _selected(image['url']),
                                focusColor: Colors.blue,
                                icon: const Icon(
                                  Icons.check_circle_outline_sharp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _upload('camera'),
                      icon: const Icon(Icons.camera),
                      label: const Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () => _upload('gallery'),
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery')),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text("Choose Date"),
              ),
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      /**ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sending Data to cloud Firestore'),
                        ),
                      );*/
                      Get.snackbar(
                        "Saving Product: $dropdown",
                        "Quantity: $quantity  Price: $price",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 5),
                      );
                      final imageUrl =
                          await storageRef.child(url).getDownloadURL();

                      DocumentReference items = FirebaseFirestore.instance
                          .collection('factory products')
                          .doc();
                      items
                          .set({
                            'name': dropdown,
                            'quantity': quantity,
                            'price': price,
                            'imageUrl': imageUrl,
                            'date': selectedDate,
                            'docId': items.id,
                            'uploaderId':
                                FirebaseAuth.instance.currentUser!.uid,
                            'uploaderEmail':
                                FirebaseAuth.instance.currentUser!.email
                          })
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const AuthGate()))))
                          .catchError(
                              (error) => print('Failed to add User: $error'));
                    }
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          )),
    );
  }

  void _selected(String select) {
    url = select;
    Get.snackbar(
      "Picture Selected",
      "",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }

  final storageRef = FirebaseStorage.instance.ref();

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'User',
              'description': 'Picture'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  //String date = "";
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
        helpText: "SELECT BOOKING DATE",
        cancelText: "CANCEL",
        confirmText: "SAVE");
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}

class FarmerEntry extends StatefulWidget {
  const FarmerEntry({Key? key}) : super(key: key);

  @override
  State<FarmerEntry> createState() => _FarmerEntryState();
}

class _FarmerEntryState extends State<FarmerEntry> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  DateTime date = DateTime.now();

  var name = '';
  var quantity = 0;
  var price = 0.0;
  var url = '';
  String? dropdown;
  //var date = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Products To Sell"),
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
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
                //width: 20,
                child: DropdownButton<String>(
                  value: dropdown,
                  elevation: 5,
                  style: const TextStyle(color: Colors.black),
                  items: <String>[
                    'Chickens',
                    'Dintshu/Gizzards',
                    'Dibete/Livers',
                    'Melala/Necks',
                    'Menoto/Feets',
                    'Mala/Intestines',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text(
                    "Press to select an item",
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
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Item Quantity',
                  labelText: 'Quantity',
                ),
                onChanged: (value) {
                  quantity = int.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter item quantity';
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'Item price',
                  labelText: 'Price',
                ),
                onChanged: (value) {
                  price = double.parse(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Price';
                  }
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data![index];

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              dense: false,
                              leading: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      child: IconButton(
                                        onPressed: () =>
                                            _selected(image['url']),
                                        icon: const Icon(
                                            Icons.check_circle_outline_sharp,
                                            color: Colors.black),
                                        hoverColor: Colors.blueGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    SizedBox(child: Image.network(image['url']))
                                  ]),
                              title: Text(image['uploaded_by']),
                              subtitle: Text(image['description']),
                              trailing: IconButton(
                                hoverColor: Colors.blueGrey,
                                focusColor: Colors.blue,
                                onPressed: () => _delete(image['path']),
                                icon: const Icon(Icons.delete_forever,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _upload('camera'),
                      icon: const Icon(Icons.camera),
                      label: const Text('camera')),
                  ElevatedButton.icon(
                      onPressed: () => _upload('gallery'),
                      icon: const Icon(Icons.library_add),
                      label: const Text('Gallery')),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text("Choose Date"),
              ),
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Get.snackbar(
                        "Saving Product: $dropdown",
                        "Quantity: $quantity  Price: $price",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 5),
                      );
                      final imageUrl =
                          await storageRef.child(url).getDownloadURL();

                      DocumentReference items = FirebaseFirestore.instance
                          .collection('Farmer products')
                          .doc();
                      items
                          .set({
                            'name': dropdown,
                            'quantity': quantity,
                            'price': price,
                            'imageUrl': imageUrl,
                            'date': selectedDate,
                            'docId': items.id,
                            'uploaderId':
                                FirebaseAuth.instance.currentUser!.uid,
                            'uploaderEmail':
                                FirebaseAuth.instance.currentUser!.email
                          })
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const AuthGate()))))
                          .catchError(
                              (error) => print('Failed to add User: $error'));
                    }
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          )),
    );
  }

  final storageRef = FirebaseStorage.instance.ref();

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': FirebaseAuth.instance.currentUser!.uid,
              'description': '$dropdown'
            }));

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
            fileMeta.customMetadata?['description'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  //String date = "";
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
        helpText: "SELECT BOOKING DATE",
        cancelText: "CANCEL",
        confirmText: "SAVE");
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  void _selected(String select) {
    url = select;
    Get.snackbar(
      "Picture Selected",
      "$dropdown",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
    );
  }
}
