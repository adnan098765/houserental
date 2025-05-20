// // lib/controllers/property_controller.dart
// import 'dart:io';
// import 'package:get/get.dart';
// import '../Screens/PropertyListingScreen/property_listing_page.dart';
//
// class PropertyController extends GetxController {
//   // Observable list of properties
//   final RxList<Property> _properties = <Property>[].obs;
//
//   // Getter for the properties list
//   List<Property> get properties => _properties;
//
//   // Getter for recommended properties (most recent first)
//   List<Property> get recommendedProperties {
//     if (_properties.isEmpty) return [];
//     // Sort by creation date (newest first) and take up to 5
//     return _properties
//         .toList()
//         .sorted((a, b) => b.createdAt.compareTo(a.createdAt))
//         .take(5)
//         .toList();
//   }
//
//   // Getter for popular properties (highest rating first)
//   List<Property> get popularProperties {
//     if (_properties.isEmpty) return [];
//     // Sort by rating (highest first) and take up to 5
//     return _properties
//         .toList()
//         .sorted((a, b) => b.rating.compareTo(a.rating))
//         .take(5)
//         .toList();
//   }
//
//   // Add a new property
//   void addProperty({
//     required String title,
//     required String type,
//     required String price,
//     required String bedrooms,
//     required String bathrooms,
//     required String location,
//     required File image,
//   }) {
//     final uuid = Uuid();
//     final newProperty = Property(
//       id: uuid.v4(),
//       title: title,
//       type: type,
//       price: price,
//       bedrooms: bedrooms,
//       bathrooms: bathrooms,
//       location: location,
//       image: image,
//       createdAt: DateTime.now(),
//     );
//
//     _properties.add(newProperty);
//     // Refresh the list to trigger UI updates
//     update();
//   }
//
//   // Initialize controller with sample data if needed
//   @override
//   void onInit() {
//     super.onInit();
//     // You can add any initial data loading logic here
//   }
// }