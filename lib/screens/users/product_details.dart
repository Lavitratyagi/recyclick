import 'package:flutter/material.dart';
import 'package:recyclick/Api%20Service/api_service.dart';
import 'package:recyclick/screens/users/product_specs.dart';

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

    setState(() {
      _isLoading = true;
    });

    try {
      // Call API service to submit product details.
      final responseText = await ApiService().submitProductDetails(
        company: company,
        model: model,
        variant: variant,
        imei: imei,
        colour: colour,
        verificationResponse: verificationResponse,
      );

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ProductSpecsPage(
                verificationResponse: verificationResponse,
                productResponse: responseText,
              ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
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
                        // IMEI No. field (for phones).
                        TextFormField(
                          controller: _imeiController,
                          decoration: InputDecoration(
                            labelText: 'IMEI No. (for phones)',
                            border: OutlineInputBorder(),
                          ),
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
                            child:
                                _isLoading
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
