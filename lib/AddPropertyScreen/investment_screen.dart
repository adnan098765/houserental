import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InvestmentPropertyScreen extends StatefulWidget {
  const InvestmentPropertyScreen({super.key});

  @override
  State<InvestmentPropertyScreen> createState() => _InvestmentPropertyScreenState();
}

class _InvestmentPropertyScreenState extends State<InvestmentPropertyScreen> {
  final List<Map<String, dynamic>> _investmentProperties = [
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
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _purchasePriceController = TextEditingController();
  final TextEditingController _currentValueController = TextEditingController();
  final TextEditingController _monthlyRentController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  DateTime? _purchaseDate;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _locationController.dispose();
    _purchasePriceController.dispose();
    _currentValueController.dispose();
    _monthlyRentController.dispose();
    _expensesController.dispose();
    super.dispose();
  }

  void _addInvestmentProperty() {
    if (_formKey.currentState!.validate()) {
      final purchasePrice = double.parse(_purchasePriceController.text);
      final currentValue = double.parse(_currentValueController.text);
      final monthlyRent = double.parse(_monthlyRentController.text);
      final expenses = double.parse(_expensesController.text);

      // Simple ROI calculation: (Annual Net Income / Total Investment) * 100
      final annualNetIncome = (monthlyRent - expenses) * 12;
      final roi = (annualNetIncome / purchasePrice) * 100;

      setState(() {
        _investmentProperties.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'name': _nameController.text,
          'type': _typeController.text,
          'location': _locationController.text,
          'purchasePrice': purchasePrice,
          'currentValue': currentValue,
          'purchaseDate': _purchaseDate != null
              ? DateFormat('yyyy-MM-dd').format(_purchaseDate!)
              : DateFormat('yyyy-MM-dd').format(DateTime.now()),
          'monthlyRent': monthlyRent,
          'expenses': expenses,
          'roi': roi,
          'image': 'assets/${_typeController.text.toLowerCase()}1.jpg',
        });

        // Reset form
        _nameController.clear();
        _typeController.clear();
        _locationController.clear();
        _purchasePriceController.clear();
        _currentValueController.clear();
        _monthlyRentController.clear();
        _expensesController.clear();
        _purchaseDate = null;
      });

      Get.back(); // Close the dialog
      Get.snackbar(
        'Success',
        'Investment property added',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void _showAddPropertyDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Add Investment Property'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Property Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'Property Type'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _purchasePriceController,
                  decoration: const InputDecoration(labelText: 'Purchase Price (\$)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purchase price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _currentValueController,
                  decoration: const InputDecoration(labelText: 'Current Value (\$)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter current value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _monthlyRentController,
                  decoration: const InputDecoration(labelText: 'Monthly Rent (\$)'),
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
                TextFormField(
                  controller: _expensesController,
                  decoration: const InputDecoration(labelText: 'Monthly Expenses (\$)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter monthly expenses';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text(
                    _purchaseDate == null
                        ? 'Select Purchase Date'
                        : 'Purchase Date: ${DateFormat('MMM dd, yyyy').format(_purchaseDate!)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _purchaseDate = date;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addInvestmentProperty,
            child: const Text('Add Property'),
          ),
        ],
      ),
    );
  }

  void _showPropertyDetails(Map<String, dynamic> property) {
    final annualNetIncome = (property['monthlyRent'] - property['expenses']) * 12;
    final appreciation = property['currentValue'] - property['purchasePrice'];
    final appreciationPercentage = (appreciation / property['purchasePrice']) * 100;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                property['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    property['location'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  property['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Icon(Icons.home, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Investment Metrics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildMetricRow('Purchase Price', '\$${property['purchasePrice'].toStringAsFixed(0)}'),
              _buildMetricRow('Current Value', '\$${property['currentValue'].toStringAsFixed(0)}'),
              _buildMetricRow('Value Appreciation', '\$${appreciation.toStringAsFixed(0)} (${appreciationPercentage.toStringAsFixed(1)}%)',
                  color: appreciation >= 0 ? Colors.green : Colors.red),
              _buildMetricRow('Monthly Rent', '\$${property['monthlyRent'].toStringAsFixed(0)}'),
              _buildMetricRow('Monthly Expenses', '\$${property['expenses'].toStringAsFixed(0)}'),
              _buildMetricRow('Monthly Cash Flow', '\$${(property['monthlyRent'] - property['expenses']).toStringAsFixed(0)}'),
              _buildMetricRow('Annual Net Income', '\$${annualNetIncome.toStringAsFixed(0)}'),
              _buildMetricRow('ROI', '${property['roi'].toStringAsFixed(1)}%',
                  color: property['roi'] >= 5 ? Colors.green : Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildMetricRow('Property Type', property['type']),
              _buildMetricRow('Purchase Date', property['purchaseDate']),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => PropertyPerformanceChart(property: property));
                  },
                  child: const Text('View Performance Chart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1565C0),
        title: const Text('Investment Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPropertyDialog,
          ),
        ],
      ),
      body: _investmentProperties.isEmpty
          ? const Center(
        child: Text(
          'No investment properties yet.\nTap the + button to add one.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _investmentProperties.length,
        itemBuilder: (context, index) {
          final property = _investmentProperties[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(property['image']),
                onBackgroundImageError: (_, __) => const Icon(Icons.home),
              ),
              title: Text(property['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property['location']),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${property['currentValue'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.trending_up,
                        color: property['currentValue'] >= property['purchasePrice']
                            ? Colors.green
                            : Colors.red,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Chip(
                backgroundColor: property['roi'] >= 5
                    ? Colors.green[100]
                    : Colors.red[100],
                label: Text(
                  '${property['roi'].toStringAsFixed(1)}% ROI',
                  style: TextStyle(
                    color: property['roi'] >= 5
                        ? Colors.green[800]
                        : Colors.red[800],
                  ),
                ),
              ),
              onTap: () => _showPropertyDetails(property),
            ),
          );
        },
      ),
    );
  }
}

class PropertyPerformanceChart extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyPerformanceChart({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    // This would be replaced with actual chart implementation (using charts_flutter or similar)
    // For demo purposes, we'll show a placeholder

    final monthlyCashFlow = property['monthlyRent'] - property['expenses'];
    final annualCashFlow = monthlyCashFlow * 12;
    final appreciation = property['currentValue'] - property['purchasePrice'];

    return Scaffold(
      appBar: AppBar(
        title: Text('${property['name']} Performance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Annual Cash Flow',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(
                          '\$${annualCashFlow.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Value Appreciation',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Center(

                        child: Text(
                          '\$${appreciation.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24,

                            fontWeight: FontWeight.bold,
                            color: appreciation >= 0 ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}