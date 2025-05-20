import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zillow_rental/AddPropertyScreen/rental_property_form.dart';

class RentalPropertyScreen extends StatefulWidget {
  const RentalPropertyScreen({Key? key}) : super(key: key);

  @override
  State<RentalPropertyScreen> createState() => _RentalPropertyScreenState();
}

class _RentalPropertyScreenState extends State<RentalPropertyScreen>
    with TickerProviderStateMixin {
  // Removed duplicate GlobalKey
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tenantNameController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedPropertyType = 'Apartment';
  bool _isAvailable = true;

  final List<Map<String, dynamic>> _properties = [
    {
      'id': '1',
      'name': 'Luxury Apartment',
      'type': 'Apartment',
      'address': '123 Main St, Lahore',
      'price': 2500,
      'description': '3 bedroom, 2 bath with city view',
      'isAvailable': true,
      'image': 'assets/images/image.png',
      'amenities': ['Swimming Pool', 'Gym', 'Parking', 'Security'],
      'bedrooms': 3,
      'bathrooms': 2,
      'area': 1200,
    },
    {
      'id': '2',
      'name': 'Suburban House',
      'type': 'House',
      'address': '456 Oak Ave, Multan',
      'price': 3200,
      'description': '4 bedroom, 3 bath with backyard',
      'isAvailable': false,
      'image': 'assets/images/image.png',
      'amenities': ['Garden', 'Garage', 'Patio', 'Solar Panels'],
      'bedrooms': 4,
      'bathrooms': 3,
      'area': 2100,
      'tenant': 'Aslam',
      'startDate': '2023-01-01',
      'endDate': '2023-12-31',
    },
    {
      'id': '3',
      'name': 'Modern Villa',
      'type': 'Villa',
      'address': '789 Park Rd, Islamabad',
      'price': 5500,
      'description': '5 bedroom luxury villa with private pool',
      'isAvailable': true,
      'image': 'assets/images/image.png',
      'amenities': ['Private Pool', 'Home Theater', 'Smart Home', 'BBQ Area'],
      'bedrooms': 5,
      'bathrooms': 4,
      'area': 3500,
    },
  ];

  final List<String> _propertyTypes = [
    'Apartment',
    'House',
    'Condo',
    'Townhouse',
    'Villa',
  ];

  int _selectedTabIndex = 0;
  final List<String> _tabs = ['All', 'Available', 'Rented'];
  String _searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _propertyNameController.dispose();
    _addressController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _tenantNameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _addProperty() {
    // Access the form key from the dialog
    final formKey = Get.find<GlobalKey<FormState>>();
    if (formKey.currentState!.validate()) {
      setState(() {
        _properties.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'name': _propertyNameController.text,
          'type': _selectedPropertyType,
          'address': _addressController.text,
          'price': double.parse(_priceController.text),
          'description': _descriptionController.text,
          'isAvailable': _isAvailable,
          'image': 'assets/images/${_selectedPropertyType.toLowerCase()}.jpg',
          'amenities': ['Parking', 'Security'],
          'bedrooms': 2,
          'bathrooms': 1,
          'area': 1000,
          if (!_isAvailable) 'tenant': _tenantNameController.text,
          if (!_isAvailable && _startDate != null)
            'startDate': DateFormat('yyyy-MM-dd').format(_startDate!),
          if (!_isAvailable && _endDate != null)
            'endDate': DateFormat('yyyy-MM-dd').format(_endDate!),
        });

        // Reset form
        _propertyNameController.clear();
        _addressController.clear();
        _priceController.clear();
        _descriptionController.clear();
        _tenantNameController.clear();
        _startDate = null;
        _endDate = null;
        _isAvailable = true;
      });

      Get.back(); // Close the dialog
      Get.snackbar(
        'Success',
        'Property added successfully',
        backgroundColor: Colors.green.shade800,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    }
  }

  void _showAddPropertyDialog() {
    // Create a unique GlobalKey for each dialog
    final formKey = GlobalKey<FormState>();
    Get.put(formKey); // Store the key for later access

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 500),
          child: Form(
            key: formKey, // Use the unique key
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add New Property',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _propertyNameController,
                    decoration: InputDecoration(
                      labelText: 'Property Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.home),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter property name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedPropertyType,
                    decoration: InputDecoration(
                      labelText: 'Property Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.category),
                    ),
                    items: _propertyTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPropertyType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Monthly Rent (Rs)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter monthly rent';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.description),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Available for Rent'),
                    subtitle: Text(
                      _isAvailable ? 'Property is available' : 'Property is occupied',
                      style: TextStyle(
                        color: _isAvailable ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    value: _isAvailable,
                    activeColor: Colors.green.shade700,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                    secondary: Icon(
                      _isAvailable ? Icons.check_circle : Icons.cancel,
                      color: _isAvailable ? Colors.green.shade700 : Colors.red.shade700,
                    ),
                  ),
                  if (!_isAvailable) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tenantNameController,
                      decoration: InputDecoration(
                        labelText: 'Tenant Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter tenant name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          _startDate == null
                              ? 'Select Start Date'
                              : 'Start: ${DateFormat('MMM dd, yyyy').format(_startDate!)}',
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.indigo.shade700,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null && mounted) {
                            setState(() {
                              _startDate = date;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          _endDate == null
                              ? 'Select End Date'
                              : 'End: ${DateFormat('MMM dd, yyyy').format(_endDate!)}',
                        ),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _startDate ?? DateTime.now(),
                            firstDate: _startDate ?? DateTime.now(),
                            lastDate: DateTime(2100),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.indigo.shade700,
                                    onPrimary: Colors.white,
                                    surface: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null && mounted) {
                            setState(() {
                              _endDate = date;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: _addProperty,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Property'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    Get.to(
          () => PropertyDetailsScreen(property: property),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  List<Map<String, dynamic>> _getFilteredProperties() {
    List<Map<String, dynamic>> filteredList = [..._properties];

    // Apply tab filter
    if (_selectedTabIndex == 1) {
      filteredList = filteredList.where((p) => p['isAvailable'] == true).toList();
    } else if (_selectedTabIndex == 2) {
      filteredList = filteredList.where((p) => p['isAvailable'] == false).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((property) {
        return property['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
            property['address'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
            property['type'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProperties = _getFilteredProperties();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Rental Properties',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.indigo.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPropertyDialog,
            tooltip: 'Add New Property',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search properties...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              Container(
                color: Colors.indigo.shade700,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  indicatorWeight: 3,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.7),
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  tabs: _tabs.map((tab) {
                    int count = 0;
                    if (tab == 'All') {
                      count = _properties.length;
                    } else if (tab == 'Available') {
                      count = _properties.where((p) => p['isAvailable'] == true).length;
                    } else if (tab == 'Rented') {
                      count = _properties.where((p) => p['isAvailable'] == false).length;
                    }
                    return Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tab),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              count.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPropertyDialog,
        backgroundColor: Colors.indigo.shade700,
        child: const Icon(Icons.add),
      ),
      body: filteredProperties.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_work,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No properties found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try changing your search criteria'
                  : 'Tap the + button to add a new property',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      )
          : CustomScrollView(
        slivers: [
          SliverPadding( // Add padding to the list
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final property = filteredProperties[index];
                  return PropertyCard(
                    property: property,
                    onTap: () => _showPropertyDetails(property),
                  );
                },
                childCount: filteredProperties.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback onTap;

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image with Status Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    property['image'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.home,
                        size: 50,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: property['isAvailable'] ? Colors.green.shade600 : Colors.red.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      property['isAvailable'] ? 'Available' : 'Rented',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      property['type'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Rs${NumberFormat('#,###').format(property['price'])}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Address
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property['address'],
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Property Features
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeature(Icons.king_bed, '${property['bedrooms']} Beds'),
                      _buildFeature(Icons.bathroom, '${property['bathrooms']} Baths'),
                      _buildFeature(Icons.square_foot, '${property['area']} sqft'),
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
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.indigo.shade700,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class PropertyDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyDetailsScreen({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Property Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.indigo.shade700,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    property['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.home, size: 100),
                    ),
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.7, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {
                    Get.snackbar(
                      'Added to Favorites',
                      '${property['name']} has been added to your favorites',
                      backgroundColor: Colors.indigo.shade700,
                      colorText: Colors.white,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Icons.favorite, color: Colors.white),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.share, color: Colors.black),
                  onPressed: () {
                    Get.snackbar(
                      'Share',
                      'Sharing ${property['name']}',
                      backgroundColor: Colors.indigo.shade700,
                      colorText: Colors.white,
                      borderRadius: 10,
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Icons.share, color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),

          // Property Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Name and Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property['name'],
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: property['isAvailable']
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              property['isAvailable'] ? Icons.check_circle : Icons.cancel,
                              size: 16,
                              color: property['isAvailable'] ? Colors.green.shade800 : Colors.red.shade800,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              property['isAvailable'] ? 'Available' : 'Rented',
                              style: TextStyle(
                                color: property['isAvailable'] ? Colors.green.shade800 : Colors.red.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          property['address'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Price and Key Features
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs${NumberFormat('#,###').format(property['price'])}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo.shade700,
                                        ),
                                      ),
                                      Text(
                                        '/month',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!property['isAvailable'])
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 18,
                                      color: Colors.indigo,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      property['tenant'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildKeyFeature(
                              context,
                              Icons.king_bed,
                              '${property['bedrooms']}',
                              'Bedrooms',
                            ),
                            _buildKeyFeature(
                              context,
                              Icons.bathroom,
                              '${property['bathrooms']}',
                              'Bathrooms',
                            ),
                            _buildKeyFeature(
                              context,
                              Icons.square_foot,
                              '${property['area']}',
                              'Sq ft',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    property['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Amenities
                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (property['amenities'] as List<dynamic>).map((amenity) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          amenity,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Conditional rental period section
                  if (!property['isAvailable']) ...[
                    const SizedBox(height: 24),

                    // Rental Period
                    const Text(
                      'Rental Period',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  property['startDate'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    property['endDate'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (property['isAvailable']) {
              Get.to(
                    () => RentPropertyForm(property: property),
                transition: Transition.rightToLeft,
              );
            } else {
              Get.snackbar(
                'Property Rented',
                'This property is currently not available for rent.',
                backgroundColor: Colors.red.shade700,
                colorText: Colors.white,
                borderRadius: 10,
                margin: const EdgeInsets.all(10),
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.info, color: Colors.white),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: property['isAvailable'] ? Colors.indigo.shade700 : Colors.grey.shade400,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            property['isAvailable'] ? 'Rent This Property' : 'Not Available',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyFeature(BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.indigo.shade700,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}