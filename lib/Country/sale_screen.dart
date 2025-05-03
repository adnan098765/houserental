import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalePropertiesScreen extends StatefulWidget {
  const SalePropertiesScreen({Key? key}) : super(key: key);

  @override
  State<SalePropertiesScreen> createState() => _SalePropertiesScreenState();
}

class _SalePropertiesScreenState extends State<SalePropertiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text('Properties for Sale'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Furnished'),
            Tab(text: 'Unfurnished'),
          ],
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Furnished Properties Tab
          _buildPropertiesList(furnished: true),

          // Unfurnished Properties Tab
          _buildPropertiesList(furnished: false),
        ],
      ),
    );
  }

  Widget _buildPropertiesList({required bool furnished}) {
    // Sample data - in a real app, fetch from API
    final properties = [
      {
        'title': 'Luxury Penthouse',
        'price': '\$1,250,000',
        'location': 'Beachfront',
        'bedrooms': '4',
        'bathrooms': '3',
        'size': '2,800 sqft',
        'image': 'assets/images/image.png',
        'status': 'For Sale',
      },
      {
        'title': 'Modern Townhouse',
        'price': '\$650,000',
        'location': 'City Center',
        'bedrooms': '3',
        'bathrooms': '2.5',
        'size': '1,800 sqft',
        'image': 'assets/images/image.png',
        'status': 'For Sale',
      },
      {
        'title': 'Garden Villa',
        'price': '\$950,000',
        'location': 'Suburbs',
        'bedrooms': '5',
        'bathrooms': '4',
        'size': '3,200 sqft',
        'image': 'assets/images/image.png',
        'status': 'For Sale',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image with Sale Tag
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                    child: Image.asset(
                      property['image']!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        property['status']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Property Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          property['price']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          property['location']!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Features
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeatureItem(
                          icon: Icons.bed,
                          text: '${property['bedrooms']} Bed',
                        ),
                        _buildFeatureItem(
                          icon: Icons.bathtub,
                          text: '${property['bathrooms']} Bath',
                        ),
                        _buildFeatureItem(
                          icon: Icons.zoom_out_map,
                          text: property['size']!,
                        ),
                        _buildFeatureItem(
                          icon: furnished ? Icons.chair : Icons.chair_outlined,
                          text: furnished ? 'Furnished' : 'Unfurnished',
                        ),
                      ],
                    ),

                    // Contact Button
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for contacting about this property
                        },
                        child: Text('Contact Seller',style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 8, color: Colors.black),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}