import 'package:flutter/material.dart';

class TopLocationsScreen extends StatefulWidget {
  const TopLocationsScreen({super.key});

  @override
  State<TopLocationsScreen> createState() => _TopLocationsScreenState();
}

class _TopLocationsScreenState extends State<TopLocationsScreen> {
  String selectedCity = "Multan";  // Fixed typo from "<u;tan>"
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
    },
    {
      "image": "assets/images/image.png",
      "title": "Garden Heights",
      "location": "Multan",
      "price": 12500,
      "rating": 4.3,
      "city": "Multan",
    },
    {
      "image": "assets/images/image.png",
      "title": "Lakeview Mansion",
      "location": "Shah Rukne Alam",
      "price": 22000,
      "rating": 4.9,
      "city": "Multan",
    },
    {
      "image": "assets/images/image.png",
      "title": "Sunrise Apartments",
      "location": "Gulgasht Colony",
      "price": 18000,
      "rating": 4.7,
      "city": "Multan",
    },

    // Lahore Properties
    {
      "image": "assets/images/image.png",
      "title": "Acorn Villa",
      "location": "Johar Town",
      "price": 17000,
      "rating": 4.4,
      "city": "Lahore",
    },
    {
      "image": "assets/images/image.png",
      "title": "Urban Heights",
      "location": "DHA Phase 5",
      "price": 21000,
      "rating": 4.5,
      "city": "Lahore",
    },
    {
      "image": "assets/images/image.png",
      "title": "Modern Living",
      "location": "Gulberg",
      "price": 13500,
      "rating": 4.2,
      "city": "Lahore",
    },
    {
      "image": "assets/images/image.png",
      "title": "Executive Suites",
      "location": "Model Town",
      "price": 24000,
      "rating": 4.8,
      "city": "Lahore",
    },

    // Islamabad Properties
    {
      "image": "assets/images/image.png",
      "title": "The Orchard",
      "location": "F-8 Markaz",
      "price": 20000,
      "rating": 4.8,
      "city": "Islambad",
    },
    {
      "image": "assets/images/image.png",
      "title": "Capital Views",
      "location": "E-11 Sector",
      "price": 24500,
      "rating": 4.9,
      "city": "Islambad",
    },
    {
      "image": "assets/images/image.png",
      "title": "Margalla Residency",
      "location": "F-10 Markaz",
      "price": 19500,
      "rating": 4.7,
      "city": "Islambad",
    },
    {
      "image": "assets/images/image.png",
      "title": "Blue Area Apartments",
      "location": "Blue Area",
      "price": 15000,
      "rating": 4.4,
      "city": "Islambad",
    },

    // Other properties
    {
      "image": "assets/images/image.png",
      "title": "Tech Park Residency",
      "location": "Hyderabad Lake",
      "price": 18000,
      "rating": 4.5,
      "city": "Hydrabad",
    },
    {
      "image": "assets/images/image.png",
      "title": "Royal Suites",
      "location": "Bahawalpur",
      "price": 16500,
      "rating": 4.6,
      "city": "Bahawalpur",
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
      // appBar: AppBar(
      //   title: const Text(
      //     'Top Locations',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      // ),
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
                        // Handle property tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Property Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                property["image"],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
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