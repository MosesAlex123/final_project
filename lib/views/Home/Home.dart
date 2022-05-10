import 'package:final_project/booking/forms/products.dart';
import 'package:final_project/booking/forms/records.dart';
import 'package:final_project/views/Profile/ConsumersProfile.dart';
import 'package:final_project/views/Profile/FactoriesProfile.dart';
import 'package:final_project/views/Profile/FarmersProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConsumerNav extends StatefulWidget {
  const ConsumerNav({Key? key}) : super(key: key);

  @override
  State<ConsumerNav> createState() => _ConsumerNavState();
}

class _ConsumerNavState extends State<ConsumerNav> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const ConsumerProfile(),
    const ProfilePage(),
    SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Shop',
        ),
      ],
      backgroundColor: Colors.blueGrey,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}

class FactoryNav extends StatefulWidget {
  const FactoryNav({Key? key}) : super(key: key);

  @override
  State<FactoryNav> createState() => _FactoryNavState();
}

class _FactoryNavState extends State<FactoryNav> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const FactoriesProfile(),
    const FactoryProfilePage(),
    SaveProduct(entrypoint: FirebaseAuth.instance.currentUser!.uid)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Shop',
        ),
      ],
      backgroundColor: Colors.blueGrey,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}

class FarmerNav extends StatefulWidget {
  const FarmerNav({Key? key}) : super(key: key);

  @override
  State<FarmerNav> createState() => _FarmerNavState();
}

class _FarmerNavState extends State<FarmerNav> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const FarmersProfile(),
    const CallBook(),
    const Book()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Shop',
        ),
      ],
      backgroundColor: Colors.blueGrey,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      onTap: _onTap,
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
