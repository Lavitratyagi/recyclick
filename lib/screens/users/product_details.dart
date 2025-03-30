import 'package:flutter/material.dart';
import 'package:recyclick/Api%20Service/api_service.dart';
import 'package:recyclick/screens/users/product_specs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsPage extends StatefulWidget {
  final String verificationResponse; // Received from image upload page

  const ProductDetailsPage({Key? key, required this.verificationResponse})
      : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field.
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _variantController = TextEditingController();
  final TextEditingController _imeiController = TextEditingController();
  final TextEditingController _colourController = TextEditingController();

  bool _isLoading = false;
  int _aadharNumber = 0;

  // Dropdown for "Type"
  final List<String> _types = ['phone', 'laptop', 'keyboard', 'mouse', 'charger', 'other'];
  String _selectedType = 'phone';

  @override
  void initState() {
    super.initState();
    _loadAadhar();
  }

  Future<void> _loadAadhar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _aadharNumber = prefs.getInt('aadhar') ?? 0;
    });
  }

  Future<void> _submitDetails() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Retrieve entered details.
    final String company = _companyController.text;
    final String model = _modelController.text;
    final String variant = _variantController.text;
    final String imei = _imeiController.text;
    final String colour = _colourController.text;
    final String verificationResponse = widget.verificationResponse;
    final String type = _selectedType;

    setState(() {
      _isLoading = true;
    });

    try {
      // First, call submitProductDetails to get the AI model response.
      final String aiResponse = await ApiService().submitProductDetails(
        company: company,
        model: model,
        variant: variant,
        imei: imei,
        colour: colour,
        verificationResponse: verificationResponse,
        type: type, // Ensure your API service supports this parameter if needed.
      );

      final String orderResponse = await ApiService().registerOrder(
        aadhar: _aadharNumber,
        imageUrl: verificationResponse, // assuming verificationResponse is the image URL
        type: type,
        company: company,
        model: model,
        variant: variant,
        imei: imei,
        color: colour,
        status: 0, // Assuming status 0 means pending or initial
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('orderId', orderResponse);

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductSpecsPage(
            verificationResponse: verificationResponse,
            productResponse: aiResponse,
            orderId: orderResponse,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents background shifting.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          // Content overlay with scrolling support.
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with logo and RecyClick text.
                Row(
                  children: [
                    Image.asset('assets/logo.png', height: 50, width: 50),
                    SizedBox(width: 10),
                    Text(
                      'RecyClick',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Centered header for the page.
                Center(
                  child: Text(
                    'Enter Product Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Form container with a semi-transparent white background.
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Dropdown for Type.
                        DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: InputDecoration(
                            labelText: 'Type',
                            border: OutlineInputBorder(),
                          ),
                          items: _types.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value[0].toUpperCase() + value.substring(1)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedType = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 15),
                        // Company Name field.
                        TextFormField(
                          controller: _companyController,
                          decoration: InputDecoration(
                            labelText: 'Company Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Company Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        // Model Name field.
                        TextFormField(
                          controller: _modelController,
                          decoration: InputDecoration(
                            labelText: 'Model Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Model Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        // Variant field.
                        TextFormField(
                          controller: _variantController,
                          decoration: InputDecoration(
                            labelText: 'Variant',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Variant';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        // IMEI No. field (for phones) - conditionally required.
                        TextFormField(
                          controller: _imeiController,
                          decoration: InputDecoration(
                            labelText: 'IMEI No. (for phones)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (_selectedType == 'phone') {
                              if (value == null || value.isEmpty) {
                                return 'Please enter IMEI No.';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        // Colour field.
                        TextFormField(
                          controller: _colourController,
                          decoration: InputDecoration(
                            labelText: 'Colour',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Colour';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Submit button.
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitDetails,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1BA133),
                              padding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
        ],
      ),
    );
  }
}
