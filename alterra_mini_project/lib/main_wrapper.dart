import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../screens/cart.dart';
import '../screens/home.dart';
import '../screens/search.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final int _index = 0;
  bool isSearchActive = false;
  late ScaffoldMessengerState _scaffoldMessenger;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    _scaffoldMessenger.hideCurrentSnackBar();
    super.dispose();
  }

  List<Widget> screens = [const Home(), const Search(), const Cart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchActive
            ? FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              )
            : FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  "Tugek Collection",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
        backgroundColor: const Color(0xFFF61C85),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearchActive = !isSearchActive;
              });
            },
            icon: isSearchActive
                ? const Icon(
                    LineIcons.searchMinus,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 30,
                  )
                : const Icon(
                    LineIcons.search,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 30,
                  ),
          ),
        ],
      ),
      body: isSearchActive ? const Search() : const Home(),
      bottomNavigationBar: BottomBarBubble(
        color: const Color(0xFFF61C85),
        selectedIndex: _index,
        backgroundColor: Colors.white,
        items: [
          BottomBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          BottomBarItem(
            iconData: Icons.shopping_cart,
            label: 'Cart',
          ),
          BottomBarItem(
            iconData: Icons.assignment,
            label: 'Task',
          ),
          BottomBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
        onSelect: (index) {
          // Lakukan sesuatu ketika item dipilih, misalnya pindah halaman
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
