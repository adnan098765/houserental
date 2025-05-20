
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF1565C0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1565C0),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1565C0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      fontFamily: 'Poppins',
    );
  }
}

// File: lib/models/property_model.dart
class PropertyModel {
  final String id;
  final String name;
  final String type;
  final String location;
  final double purchasePrice;
  final double currentValue;
  final DateTime purchaseDate;
  final double monthlyRent;
  final double expenses;
  final double roi;
  final String image;
  final Color color;

  PropertyModel({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.purchasePrice,
    required this.currentValue,
    required this.purchaseDate,
    required this.monthlyRent,
    required this.expenses,
    required this.roi,
    required this.image,
    required this.color,
  });

  // Getters for calculated values
  double get monthlyCashFlow => monthlyRent - expenses;
  double get annualCashFlow => monthlyCashFlow * 12;
  double get appreciation => currentValue - purchasePrice;
  double get appreciationPercentage => (appreciation / purchasePrice) * 100;
  double get yearsHeld => DateTime.now().difference(purchaseDate).inDays / 365;
  double get annualAppreciationRate => yearsHeld > 0 ? appreciationPercentage / yearsHeld : 0;

  // Convert from Map (for loading from storage or API)
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      location: map['location'],
      purchasePrice: map['purchasePrice'] is int
          ? map['purchasePrice'].toDouble()
          : map['purchasePrice'],
      currentValue: map['currentValue'] is int
          ? map['currentValue'].toDouble()
          : map['currentValue'],
      purchaseDate: DateTime.parse(map['purchaseDate']),
      monthlyRent: map['monthlyRent'] is int
          ? map['monthlyRent'].toDouble()
          : map['monthlyRent'],
      expenses: map['expenses'] is int
          ? map['expenses'].toDouble()
          : map['expenses'],
      roi: map['roi'] is int ? map['roi'].toDouble() : map['roi'],
      image: map['image'],
      color: map['color'] ?? Colors.blue,
    );
  }

  // Convert to Map (for saving to storage or API)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'purchasePrice': purchasePrice,
      'currentValue': currentValue,
      'purchaseDate': purchaseDate.toIso8601String(),
      'monthlyRent': monthlyRent,
      'expenses': expenses,
      'roi': roi,
      'image': image,
      'color': color,
    };
  }
}


class PropertyController extends GetxController with SingleGetTickerProviderMixin {
  var properties = <PropertyModel>[].obs;
  var totalValue = 0.0.obs;
  var averageROI = 0.0.obs;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    loadInitialProperties();
    calculateSummaryData();
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void loadInitialProperties() {
    final List<Map<String, dynamic>> initialData = [
      {
        'id': '1',
        'name': 'Downtown Condo',
        'type': 'Condo',
        'location': 'Financial District, NY',
        'purchasePrice': 750000,
        'currentValue': 920000,
        'purchaseDate': '2020-05-15',
        'monthlyRent': 4500,
        'expenses': 1200,
        'roi': 8.7,
        'image': 'assets/images/image.png',
        'color': Colors.blue,
      },
      {
        'id': '2',
        'name': 'Suburban Duplex',
        'type': 'Multi-family',
        'location': 'Brooklyn, NY',
        'purchasePrice': 950000,
        'currentValue': 1100000,
        'purchaseDate': '2019-11-20',
        'monthlyRent': 6200,
        'expenses': 1800,
        'roi': 9.2,
        'image': 'assets/images/image.png',
        'color': Colors.green,
      },
    ];

    properties.value = initialData.map((data) => PropertyModel.fromMap(data)).toList();
  }

  void calculateSummaryData() {
    if (properties.isEmpty) {
      totalValue.value = 0;
      averageROI.value = 0;
      return;
    }

    double total = 0;
    double roiSum = 0;

    for (var property in properties) {
      total += property.currentValue;
      roiSum += property.roi;
    }

    totalValue.value = total;
    averageROI.value = roiSum / properties.length;
  }

  void addProperty(PropertyModel property) {
    properties.add(property);
    calculateSummaryData();
  }

  List<Color> getPropertyColors() {
    return [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.purple.shade600,
      Colors.orange.shade600,
      Colors.teal.shade600,
      Colors.pink.shade600,
    ];
  }

  Color getRandomColor() {
    final colors = getPropertyColors();
    return colors[math.Random().nextInt(colors.length)];
  }
}