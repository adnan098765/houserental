import 'package:flutter/material.dart';

import '../Detail/screen/detail_screen.dart';

class TopLocationsScreen extends StatefulWidget {
  const TopLocationsScreen({super.key});

  @override
  State<TopLocationsScreen> createState() => _TopLocationsScreenState();
}

class _TopLocationsScreenState extends State<TopLocationsScreen> {
  String selectedCity = "Multan";
  String selectedPriceRange = "10k - 15k";

  final List<String> cities = ["Multan", "Lahore", "Islambad"];
  final List<String> priceRanges = ["10k - 15k", "15k - 20k", "20k - 25k"];

  final List<Map<String, dynamic>> allProperties = [
    // Multan Properties
    {
      "image": "assets/images/image.png",
      "title": "Maharani Villa",
      "location": "Multan",
      "price": 14000,
      "rating": 4.6,
      "city": "Multan",
      "id": "multan-villa-1",
      "description": "Experience this beautiful villa with breathtaking views and excellent service. Perfect for families looking for quality and value."
    },
    {
      "image": "assets/images/image.png",
      "title": "Garden Heights",
      "location": "Multan",
      "price": 12500,
      "rating": 4.3,
      "city": "Multan",
      "id": "multan-heights-1",
      "description": "Modern living with garden views in the heart of Multan. All amenities included with excellent security."
    },
    {
      "image": "assets/images/image.png",
      "title": "Lakeview Mansion",
      "location": "Shah Rukne Alam",
      "price": 22000,
      "rating": 4.9,
      "city": "Multan",
      "id": "multan-lake-1",
      "description": "Luxurious mansion overlooking the lake with premium finishes and spacious rooms. Perfect for upscale living."
    },
    {
      "image": "assets/images/image.png",
      "title": "Sunrise Apartments",
      "location": "Gulgasht Colony",
      "price": 18000,
      "rating": 4.7,
      "city": "Multan",
      "id": "multan-sunrise-1",
      "description": "Modern apartments with sunrise views and all the amenities you need for comfortable living."
    },

    // Lahore Properties
    {
      "image": "assets/images/image.png",
      "title": "Acorn Villa",
      "location": "Johar Town",
      "price": 17000,
      "rating": 4.4,
      "city": "Lahore",
      "id": "lahore-acorn-1",
      "description": "Beautiful villa located in the prestigious Johar Town area with easy access to shopping and entertainment."
    },
    {
      "image": "assets/images/image.png",
      "title": "Urban Heights",
      "location": "DHA Phase 5",
      "price": 21000,
      "rating": 4.5,
      "city": "Lahore",
      "id": "lahore-urban-1",
      "description": "Premium apartment in DHA Phase 5 with beautiful views and modern amenities for comfortable living."
    },
    {
      "image": "assets/images/image.png",
      "title": "Modern Living",
      "location": "Gulberg",
      "price": 13500,
      "rating": 4.2,
      "city": "Lahore",
      "id": "lahore-modern-1",
      "description": "Contemporary living spaces in the heart of Gulberg, offering convenience and style at an affordable price."
    },
    {
      "image": "assets/images/image.png",
      "title": "Executive Suites",
      "location": "Model Town",
      "price": 24000,
      "rating": 4.8,
      "city": "Lahore",
      "id": "lahore-executive-1",
      "description": "Luxury executive suites in Model Town with premium amenities and excellent security for discerning professionals."
    },

    // Islamabad Properties
    {
      "image": "assets/images/image.png",
      "title": "The Orchard",
      "location": "F-8 Markaz",
      "price": 20000,
      "rating": 4.8,
      "city": "Islambad",
      "id": "islamabad-orchard-1",
      "description": "Beautiful property surrounded by nature in the heart of F-8 Markaz with modern amenities and secure environment."
    },
    {
      "image": "assets/images/image.png",
      "title": "Capital Views",
      "location": "E-11 Sector",
      "price": 24500,
      "rating": 4.9,
      "city": "Islambad",
      "id": "islamabad-capital-1",
      "description": "Premium apartments with stunning views of the capital city, offering luxury living in a prime location."
    },
    {
      "image": "assets/images/image.png",
      "title": "Margalla Residency",
      "location": "F-10 Markaz",
      "price": 19500,
      "rating": 4.7,
      "city": "Islambad",
      "id": "islamabad-margalla-1",
      "description": "Elegant residency with views of the Margalla Hills, offering premium living with all modern amenities."
    },
    {
      "image": "assets/images/image.png",
      "title": "Blue Area Apartments",
      "location": "Blue Area",
      "price": 15000,
      "rating": 4.4,
      "city": "Islambad",
      "id": "islamabad-blue-1",
      "description": "Centrally located apartments in Blue Area with easy access to business districts and shopping areas."
    },

    // Other properties
    {
      "image": "assets/images/image.png",
      "title": "Tech Park Residency",
      "location": "Hyderabad Lake",
      "price": 18000,
      "rating": 4.5,
      "city": "Hydrabad",
      "id": "hyderabad-tech-1",
      "description": "Modern living spaces near Tech Park with all amenities for comfortable family living."
    },
    {
      "image": "assets/images/image.png",
      "title": "Royal Suites",
      "location": "Bahawalpur",
      "price": 16500,
      "rating": 4.6,
      "city": "Bahawalpur",
      "id": "bahawalpur-royal-1",
      "description": "Royal living experience in the heart of Bahawalpur with premium amenities and excellent service."
    },
  ];

  final Set<int> favoriteIndexes = {};

  List<Map<String, dynamic>> get filteredProperties {
    return allProperties.where((property) {
      bool matchCity = property["city"] == selectedCity;
      bool matchPrice = () {
        int price = property["price"];
        switch (selectedPriceRange) {
          case "10k - 15k":
            return price >= 10000 && price <= 15000;
          case "15k - 20k":
            return price > 15000 && price <= 20000;
          case "20k - 25k":
            return price > 20000 && price <= 25000;
          default:
            return true;
        }
      }();
      return matchCity && matchPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Top Locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Locations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // City Filter
            const Text(
              'Select City',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(city),
                      selected: selectedCity == city,
                      selectedColor: Colors.purple.shade100,
                      labelStyle: TextStyle(
                        color: selectedCity == city ? Colors.purple : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) => setState(() => selectedCity = city),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Price Filter
            const Text(
              'Price Range',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: priceRanges.length,
                itemBuilder: (context, index) {
                  final price = priceRanges[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text("Rs$price"),
                      selected: selectedPriceRange == price,
                      selectedColor: Colors.pink.shade50,
                      labelStyle: TextStyle(
                        color: selectedPriceRange == price ? Colors.pink : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) => setState(() => selectedPriceRange = price),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Results Count
            Text(
              '${filteredProperties.length} properties found',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Property Cards
            Expanded(
              child: ListView.builder(
                itemCount: filteredProperties.length,
                itemBuilder: (context, index) {
                  final property = filteredProperties[index];
                  final isFavorite = favoriteIndexes.contains(allProperties.indexOf(property));

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Navigate to detail screen with the property data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              category: {
                                'id': property["id"],
                                'title': property["title"],
                                'image': property["image"],
                                'location': property["location"],
                                'price': "Rs${property["price"]}/month",
                                'rating': property["rating"],
                                'description': property["description"],
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Property Image
                            Hero(
                              tag: 'category-${property["id"]}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  property["image"],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Property Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    property["title"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        property["location"],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Rs${property["price"]}/month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.purple.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Rating and Favorite
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      final propertyIndex = allProperties.indexOf(property);
                                      if (isFavorite) {
                                        favoriteIndexes.remove(propertyIndex);
                                      } else {
                                        favoriteIndexes.add(propertyIndex);
                                      }
                                    });
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        property["rating"].toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
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
            ),
          ],
        ),
      ),
    );
  }
}