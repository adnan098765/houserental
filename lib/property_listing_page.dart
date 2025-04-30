import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class PropertyListingPage extends StatefulWidget {
  const PropertyListingPage({super.key});

  @override
  State<PropertyListingPage> createState() => _PropertyListingPageState();
}

class _PropertyListingPageState extends State<PropertyListingPage> {
  int _currentIndex = 0; // 0 = Sell, 1 = Rent
  final TextEditingController _searchController = TextEditingController();

  // Added state variables for range slider
  RangeValues _priceRange = const RangeValues(0, 10000000);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by location...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
              ),
              onChanged: (value) {
                // Implement search functionality
              },
            ),
          ),

          // Sell/Rent Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('For Sale'),
                    selected: _currentIndex == 0,
                    onSelected: (selected) {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                ),
                 SizedBox(width: width*0.010),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('For Rent'),
                    selected: _currentIndex == 1,
                    onSelected: (selected) {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Property List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount:
              _currentIndex == 0
                  ? forSaleProperties.length
                  : forRentProperties.length,
              itemBuilder: (context, index) {
                final property =
                _currentIndex == 0
                    ? forSaleProperties[index]
                    : forRentProperties[index];
                return PropertyCard(property: property);
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        // Create local variables for state to be used in the bottom sheet
        RangeValues tempPriceRange = _priceRange;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              double height = MediaQuery.of(context).size.height;
              double width = MediaQuery.of(context).size.width;
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Filters',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: height*0.016),
                    // Price Range
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Price Range'),
                    ),
                    RangeSlider(
                      values: tempPriceRange,
                      min: 0,
                      max: 10000000,
                      divisions: 10,
                      labels: RangeLabels(
                        'Rs${tempPriceRange.start.toInt()}',
                        'Rs${tempPriceRange.end.toInt()}',
                      ),
                      onChanged: (RangeValues values) {
                        setModalState(() {
                          tempPriceRange = values;
                        });
                      },
                    ),
                    // Display selected price range
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rs${tempPriceRange.start.toInt()}'),
                          Text('Rs${tempPriceRange.end.toInt()}'),
                        ],
                      ),
                    ),
                    // Bedrooms
                     SizedBox(height:height*0.016),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Bedrooms'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return FilterChip(
                          label: Text(index == 4 ? '4+' : (index + 1).toString()),
                          onSelected: (bool value) {
                            // Add bedroom filter functionality here if needed
                          },
                        );
                      }),
                    ),
                     SizedBox(height: height*0.016),
                    ElevatedButton(
                      onPressed: () {
                        // Apply the filters to main state
                        setState(() {
                          _priceRange = tempPriceRange;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to property details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image - Changed to use asset images
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                property.imageUrl,
                height: height*0.250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Property Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Favorite
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs ${property.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          property.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: property.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  // Title and Location
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                   SizedBox(height: height*0.006),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                       SizedBox(width: 4),
                      Text(
                        property.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),

                  // Features
                   SizedBox(height:height *0.010),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeature(Icons.bed, '${property.bedrooms} Beds'),
                      _buildFeature(
                        Icons.bathtub,
                        '${property.bathrooms} Baths',
                      ),
                      _buildFeature(
                        Icons.square_foot,
                        '${property.area} sq.ft',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [Icon(icon, size: 18), const SizedBox(width: 4), Text(text)],
    );
  }
}

class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final String imageUrl;
  final int bedrooms;
  final int bathrooms;
  final double area;
  bool isFavorite;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    this.isFavorite = false,
  });
}

// Sample Data with updated asset image paths
List<Property> forSaleProperties = [
  Property(
    id: '1',
    title: 'Modern Apartment in City Center',
    location: 'Multan Housing society',
    price: 7500000,
    imageUrl: 'assets/images/image.png', // Changed to asset image
    bedrooms: 3,
    bathrooms: 2,
    area: 1800,
  ),
  Property(
    id: '2',
    title: 'Luxury Villa with Pool',
    location: 'Lahore Model Town',
    price: 15000000,
    imageUrl: 'assets/images/image.png', // Changed to asset image
    bedrooms: 4,
    bathrooms: 3,
    area: 3200,
  ),
];

List<Property> forRentProperties = [
  Property(
    id: '3',
    title: 'Cozy 2BHK Flat',
    location: 'Peshawar',
    price: 25000,
    imageUrl: 'assets/images/image.png',
    bedrooms: 2,
    bathrooms: 1,
    area: 1100,
  ),
  Property(
    id: '4',
    title: 'Furnished Studio Apartment',
    location: 'Lahore Johar Town',
    price: 18000,
    imageUrl: 'assets/images/image.png',
    bedrooms: 1,
    bathrooms: 1,
    area: 800,
  ),
];