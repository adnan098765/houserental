import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zillow_rental/Country/buy_screen.dart';
import 'package:zillow_rental/Country/sale_screen.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img.png',
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10),
            Text(
              'Hotline Associates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          // Country Picker Field
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _countryController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Selected Country',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _showCountryPicker(context);
                  },
                ),
                prefixIcon: Icon(Icons.location_on),
                filled: true,
                fillColor: Colors.white,
              ),
              onTap: () {
                _showCountryPicker(context);
              },
            ),
          ),

          // Four Containers Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  // Buy Container
                  InkWell(
                    onTap: (){
                      Get.to(BuyPropertiesScreen());
                    },
                    child: _buildActionContainer(
                      context: context,
                      title: 'Buy',
                      color: Colors.blue,
                      icon: Icons.shopping_cart,
                    ),
                  ),

                  // Sale Container
                  InkWell(
                    onTap: (){
                      Get.to(SalePropertiesScreen());
                    },
                    child: _buildActionContainer(
                      context: context,
                      title: 'Sale',
                      color: Colors.green,
                      icon: Icons.attach_money,
                    ),
                  ),

                  // Rent Container
                  _buildActionContainer(
                    context: context,
                    title: 'Rent',
                    color: Colors.orange,
                    icon: Icons.home_work,
                  ),

                  // Invest Container
                  _buildActionContainer(
                    context: context,
                    title: 'Invest',
                    color: Colors.purple,
                    icon: Icons.trending_up,
                  ),
                ],
              ),
            ),
          ),
        ],
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
          _countryController.text = "${country.flagEmoji} ${country.name} (${country.phoneCode})";
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
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
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildActionContainer({
    required BuildContext context,
    required String title,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color), // Reduced icon size from 40 to 30
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18, // Reduced text size from 24 to 18
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}