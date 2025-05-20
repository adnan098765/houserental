import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      "image": "assets/images/image.png",
      "title": "Maharani Villa",
      "location": "Multan",
      "price": 19000,
      "status": "Completed",
    },
    {
      "image": "assets/images/image.png",
      "title": "Acorn Villa",
      "location": "Lahore",
      "price": 17000,
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Booking"), backgroundColor: Colors.white),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    booking["image"],
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Rs ${booking["price"]} /m",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      // Location
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text(
                            booking["location"],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Booking Status
                      Text(
                        "Booking Status:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          booking["status"] == "Completed"
                              ? _statusChip(
                                "Completed",
                                Colors.purple.shade100,
                                Colors.purple,
                              )
                              : _statusChip(
                                "Pending",
                                Colors.grey.shade300,
                                Colors.grey,
                              ),
                          SizedBox(width: 10),
                          booking["status"] == "Pending"
                              ? _statusChip(
                                "Completed",
                                Colors.purple.shade100,
                                Colors.purple,
                              )
                              : _statusChip(
                                "Pending",
                                Colors.grey.shade300,
                                Colors.grey,
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
      ),
    );
  }

  Widget _statusChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
