import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zillow_rental/Screens/ProfileScreen/profile_screen.dart';
import 'package:zillow_rental/Screens/PropertyListingScreen/property_listing_page.dart';
import 'package:zillow_rental/Screens/TopLocationScreen/top_location_screen.dart';
import 'package:zillow_rental/Screens/BookingScreen/booking_screen.dart';
import 'package:zillow_rental/Screens/HomeScreen/home.dart';
import 'dart:math' as math;

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> with SingleTickerProviderStateMixin {
  int _page = 2;
  final List<Widget> _screens = [
    TopLocationsScreen(),
    PropertyListingPage(),
    HomeScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // App theme colors
    const primaryGradientStart = Color(0xFF00E6FF);
    const primaryGradientEnd = Color(0xFFAE00E9);
    const cardColor = Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: _buildDrawer(context),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Background design with subtle pattern
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              image: DecorationImage(
                image: AssetImage('assets/images/subtle_pattern.png'),
                repeat: ImageRepeat.repeat,
                opacity: 0.05,
              ),
            ),
          ),

          // Main content
          _screens[_page],

          // Bottom navigation bar shadow
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.03),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      // floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 8),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: _buildDrawerItems(),
                ),
              ),
            ),
            Divider(thickness: 1),
            _buildLogoutTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      constraints: BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 35, color: Color(0xFFAE00E9)),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, User!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDrawerItems() {
    final drawerItems = [
      {'icon': Icons.home, 'title': 'Home', 'index': 2},
      {'icon': Icons.calendar_today, 'title': 'Bookings', 'index': 3},
      {'icon': Icons.location_on, 'title': 'Top Locations', 'index': 0},
      {'icon': Icons.home_work, 'title': 'Properties', 'index': 1},
      {'icon': Icons.favorite, 'title': 'Favorites', 'index': null},
      {'icon': Icons.notifications, 'title': 'Notifications', 'index': null},
      {'icon': Icons.settings, 'title': 'Settings', 'index': null},
      {'icon': Icons.help_outline, 'title': 'Help & Support', 'index': null},
    ];

    return drawerItems.map((item) {
      final isActive = item['index'] == _page;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Material(
          color: isActive ? Color(0xFFAE00E9).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (item['index'] != null) {
                setState(() {
                  _page = item['index'] as int;
                });
              }
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isActive ? Color(0xFFAE00E9) : Colors.grey[700],
                    size: 22,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: isActive ? Color(0xFFAE00E9) : Colors.grey[800],
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isActive)
                    Container(
                      width: 4,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color(0xFFAE00E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildLogoutTile() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      child: InkWell(
        onTap: () {
          // Implement logout functionality
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.shade300),
            color: Colors.red.withOpacity(0.05),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, size: 20, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Text(
              "Hotline Associate",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            decoration: BoxDecoration(
              color: Color(0xFFAE00E9).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "PREMIUM",
              style: TextStyle(
                color: Color(0xFFAE00E9),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        // _buildSearchButton(),
        _buildNotificationButton(),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      icon: Icon(Icons.search, color: Colors.grey[800]),
      onPressed: () {
        // Implement search functionality
      },
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.grey[800]),
          onPressed: () {
            // Implement notifications
          },
        ),
        Positioned(
          top: 14,
          right: 14,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      child: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.location_on, color: Colors.white),
            label: 'Locations',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.home_work, color: Colors.white),
            label: 'Properties',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_today, color: Colors.white),
            label: 'Bookings',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeOutQuint,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _page = index;
            _animationController.reset();
            _animationController.forward();
          });
        },
        letIndexChange: (index) => true,
        height: 65,
        buttonGradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
          transform: GradientRotation(85.84 * math.pi / 180),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
          transform: GradientRotation(85.84 * math.pi / 180),
        ),
      ),
    );
  }

  // Widget _buildFloatingActionButton() {
  //   return AnimatedBuilder(
  //     animation: _animationController,
  //     builder: (context, child) {
  //       return FloatingActionButton(
  //         onPressed: () {
  //           // Add new property or booking
  //           _animationController.reset();
  //           _animationController.forward();
  //         },
  //         backgroundColor: Colors.white,
  //         elevation: 5,
  //         child: Container(
  //           width: 60,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [Color(0xFF00E6FF), Color(0xFFAE00E9)],
  //             ),
  //           ),
  //           child: Icon(
  //             Icons.add,
  //             color: Colors.white,
  //             size: 30,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}