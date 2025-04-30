import 'package:flutter/material.dart';

import 'detail_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  AllCategoriesScreen({super.key});

  // List of Pakistani cities
  final List<String> pakistaniCities = [
    'Lahore', 'Karachi', 'Islamabad', 'Rawalpindi', 'Multan',
    'Faisalabad', 'Peshawar', 'Quetta', 'Sialkot', 'Gujranwala',
    'Hyderabad', 'Bahawalpur', 'Sukkur', 'Muzaffarabad', 'Mirpur',
    'Abbottabad', 'Gwadar', 'Sargodha', 'Sahiwal', 'Larkana',
  ];

  // List of Pakistani property developments and areas
  final List<String> developments = [
    'Bahria Town', 'DHA Phase', 'Gulberg', 'Model Town', 'Johar Town',
    'Askari', 'Cantt Area', 'Eden Gardens', 'Park View', 'Al-Kabir Town',
    'Wapda Town', 'Navy Housing', 'Clifton', 'Satellite Town', 'Lake City',
    'Royal Residencia', 'Fazaia Housing', 'Gulshan-e-Iqbal', 'F-10 Sector', 'E-11 Sector',
  ];

  // List of property types
  final List<String> propertyTypes = [
    'House', 'Apartment', 'Villa', 'Penthouse', 'Bungalow',
    'Flat', 'Studio', '', 'Townhouse', 'Cottage',
  ];

  late final List<Map<String, dynamic>> categories = List.generate(25, (index) {
    // Get random city and area
    final city = pakistaniCities[index % pakistaniCities.length];
    final development = developments[index % developments.length];
    final propertyType = propertyTypes[index % propertyTypes.length];

    // Generate property name based on location
    final propertyName = '${development} ${propertyType}';

    // Generate price (different ranges based on property type)
    int basePrice = 0;
    switch (propertyType) {
      case 'Penthouse':
      case 'Villa':
      case 'Bungalow':
        basePrice = 15000000 + (index * 500000);
        break;
      case 'House':
      case 'Farmhouse':
        basePrice = 8000000 + (index * 300000);
        break;
      case 'Apartment':
      case 'Townhouse':
        basePrice = 5000000 + (index * 200000);
        break;
      case 'Flat':
      case 'Studio':
      case 'Cottage':
        basePrice = 2500000 + (index * 150000);
        break;
      default:
        basePrice = 4000000 + (index * 250000);
    }

    final formattedPrice = basePrice.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'
    );

    // Generate rating based on property type and index
    double rating = 3.5 + ((index % 3) * 0.5);
    if (propertyType == 'Penthouse' || propertyType == 'Villa' || propertyType == 'Bungalow') {
      rating = 4.5;
    }

    return {
      'id': 'property_$index',
      'image': 'assets/images/image.png',
      'title': propertyName,
      'location': city,
      'price': 'Rs $formattedPrice',
      'rating': rating.toStringAsFixed(1),
      'description': 'Luxurious $propertyType located in $development, $city. This property offers modern amenities, beautiful interiors and is close to all major facilities.',
    };
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Properties'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailScreen(category: item),
                ),
              );
            },
            child: Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 6),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                item['location'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['price'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Icon(Icons.favorite_border,
                            color: Colors.red, size: 20),
                        SizedBox(height: height * 0.010),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                item['rating'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}