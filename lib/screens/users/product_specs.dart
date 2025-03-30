import 'package:flutter/material.dart';
import 'package:recyclick/screens/users/order_confirm.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ProductSpecsPage extends StatefulWidget {
  final String verificationResponse;
  final String productResponse;
  final String orderId;

  const ProductSpecsPage({
    Key? key,
    required this.verificationResponse,
    required this.productResponse,
    required this.orderId,
  }) : super(key: key);

  @override
  _ProductSpecsPageState createState() => _ProductSpecsPageState();
}

class _ProductSpecsPageState extends State<ProductSpecsPage> {
  @override
  Widget build(BuildContext context) {
    final String verificationData = widget.verificationResponse
        .replaceAll(r'\n', '\n')
        .replaceAll(r'\t', '\t');
    final String productData = widget.productResponse
        .replaceAll(r'\n', '\n')
        .replaceAll(r'\t', '\t');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Full-screen background image.
          Positioned.fill(
            child: Image.asset('assets/user_bg.png', fit: BoxFit.cover),
          ),
          // Scrollable content.
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 100),
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
                // Centered header.
                Center(
                  child: Text(
                    'Product Specifications',
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
                // Display the verification response using MarkdownBody.
                Text(
                  'Verification Response:',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                MarkdownBody(
                  data: verificationData,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Display the product response using MarkdownBody.
                Text(
                  'Product Response:',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                MarkdownBody(
                  data: productData,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Additional content placeholder.
                Text(
                  'Enter additional product details or specifications here if required.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 150), // Extra space for the bottom button.
              ],
            ),
          ),
          // Positioned button at the bottom.
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderConfirmationPage(orderId: widget.orderId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1BA133),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Confirm your order',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
