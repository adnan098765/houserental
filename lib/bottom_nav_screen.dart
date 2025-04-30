import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zillow_rental/profile_screen.dart';
import 'package:zillow_rental/property_listing_page.dart';
import 'package:zillow_rental/top_location_screen.dart';
import 'package:zillow_rental/booking_screen.dart';
import 'package:zillow_rental/home.dart';
import 'dart:math' as math;

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _page = 2;
  final List<Widget> _screens = [

    TopLocationsScreen(),
    PropertyListingPage(),
    HomeScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HouseHub", style: TextStyle(color: Colors.purple)),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.notifications_none, color: Colors.black),
        )],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.menu, color: Colors.black),
        ),
      ),
      body:
          _screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page, // Use current page index
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.location_on, color: Colors.white),
            label: 'Location',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.home_work, color: Colors.white),
            label: 'Property',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_today, color: Colors.white),
            label: 'Booking',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity, color: Colors.white),
            label: 'Profile',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        buttonGradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
          transform: GradientRotation(85.84 * math.pi / 180),
        ),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
          transform: GradientRotation(85.84 * math.pi / 180),
        ),
      ),
    );
  }
}
