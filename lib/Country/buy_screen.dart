import 'package:flutter/material.dart';

class BuyPropertiesScreen extends StatefulWidget {
  const BuyPropertiesScreen({Key? key}) : super(key: key);

  @override
  State<BuyPropertiesScreen> createState() => _BuyPropertiesScreenState();
}

class _BuyPropertiesScreenState extends State<BuyPropertiesScreen>
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
        title: const Text('Buy Properties'),
        bottom: TabBar(

          automaticIndicatorColorAdjustment: true,
          controller: _tabController,
          tabs: const [

            Tab(text: 'Furnished'),
            Tab(text: 'Unfurnished'),
          ],
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14),
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
    // Sample data
    final properties = [
      {
        'title': 'Modern Apartment',
        'price': '\$250,000',
        'location': 'Downtown',
        'bedrooms': '3',
        'bathrooms': '2',
        'size': '1,200 sqft',
        'image': "assets/images/image.png", // Updated to use asset image
      },
      {
        'title': 'Luxury Villa',
        'price': '\$750,000',
        'location': 'Uptown',
        'bedrooms': '5',
        'bathrooms': '4',
        'size': '3,500 sqft',
        'image': "assets/images/image.png", // Updated to use asset image
      },
      {
        'title': 'Cozy Studio',
        'price': '\$120,000',
        'location': 'Midtown',
        'bedrooms': '1',
        'bathrooms': '1',
        'size': '600 sqft',
        'image': "assets/images/img.png", // Updated to use asset image
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
              // Property Image - Now using AssetImage
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
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

              // Rest of your existing code remains the same...
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
        Icon(icon, size: 10, color: Colors.grey),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(color: Colors.grey,overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}