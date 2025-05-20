import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zillow_rental/AddPropertyScreen/investment_screen.dart';
import 'package:zillow_rental/AddPropertyScreen/rental_property_screen.dart';
import 'package:zillow_rental/Country/buy_screen.dart';
import 'package:zillow_rental/Country/sale_screen.dart';
import 'package:zillow_rental/bottom_nav_screen.dart';

class CountryScreen extends StatefulWidget {
  CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  Country? _selectedCountry;
  final TextEditingController _countryController = TextEditingController();

  @override
  void dispose() {
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            Text(
              'Hotline Associates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFF1565C0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Animated Logo Container
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.8, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue[300]!,
                            Colors.blue[800]!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/img_1.png"),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 22),
              Text(
                "Hotline Associates",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      color: Colors.blue.withOpacity(0.3),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Your Trusted Real Estate Partner ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              // Country Selector
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Color(0xFFF5F9FF)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _countryController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Select Your Country',
                    labelStyle: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'Tap to select country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blue.shade500, width: 2),
                    ),
                    suffixIcon: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.public, color: Colors.blue[800]),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  ),
                  onTap: () {
                    _showCountryPicker(context);
                  },
                ),
              ),
              const SizedBox(height: 35),
              // Actions Heading
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 15),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 6,
                      child: Container(
                        height: 2,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                    Text(
                      "What would you like to do?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                  ],
                ),
              ),
              // Actions Grid
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildEnhancedActionContainer(
                    onTap: () {
                      Get.to(BuyPropertiesScreen());
                    },
                    title: 'Buy',
                    primaryColor: Color(0xFF1E88E5),
                    secondaryColor: Color(0xFF64B5F6),
                    icon: Icons.home,
                    description: 'Find your dream home',
                  ),
                  _buildEnhancedActionContainer(
                    onTap: () {
                      Get.to(SalePropertiesScreen());
                    },
                    title: 'Sale',
                    primaryColor: Color(0xFF43A047),
                    secondaryColor: Color(0xFF81C784),
                    icon: Icons.monetization_on,
                    description: 'List your property',
                  ),
                  _buildEnhancedActionContainer(
                    onTap: () {
                      Get.to(RentalPropertyScreen());
                    },
                    title: 'Rent',
                    primaryColor: Color(0xFFEF6C00),
                    secondaryColor: Color(0xFFFFB74D),
                    icon: Icons.apartment,
                    description: 'Find rental properties',
                  ),
                  _buildEnhancedActionContainer(
                    onTap: () {
                      Get.to(InvestmentPropertyScreen());
                    },
                    title: 'Invest',
                    primaryColor: Color(0xFF7B1FA2),
                    secondaryColor: Color(0xFFBA68C8),
                    icon: Icons.timeline,
                    description: 'Grow your portfolio',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Promotional Card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 22),
                        SizedBox(width: 8),
                        Text(
                          "FEATURED",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "New Properties Available",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Discover exclusive listings in prime locations",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                       Get.to(BottomNavScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue[800],
                          backgroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Explore Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      exclude: <String>['KN', 'MF'],
      favorite: <String>['Pak'],
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _countryController.text = "${country.flagEmoji} ${country.name}";
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        searchTextStyle: TextStyle(
          color: Colors.blue[800],
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildEnhancedActionContainer({
    required VoidCallback onTap,
    required String title,
    required Color primaryColor,
    required Color secondaryColor,
    required IconData icon,
    required String description,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF5F9FF)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container with gradient
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, secondaryColor],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 14),
            // Title with bottom border
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: 6),
            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}