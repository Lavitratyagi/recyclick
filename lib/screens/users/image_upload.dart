// photo_upload_page.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:recyclick/Api%20Service/api_service.dart';
import 'package:recyclick/screens/users/product_details.dart';

class PhotoUploadPage extends StatefulWidget {
  @override
  _PhotoUploadPageState createState() => _PhotoUploadPageState();
}

class _PhotoUploadPageState extends State<PhotoUploadPage> {
  File? _frontImage;
  File? _backImage;
  bool _isLoading = false; // For showing progress indicator

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFrontImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _frontImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickBackImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _backImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _verifyPhotos() async {
    // Validate that both images have been selected.
    if (_frontImage == null || _backImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please upload both front and back images.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Initialize the API service.
    final apiService = ApiService();
    // Call the API to verify photos.
    final responseText = await apiService.verifyPhotos(
      frontImage: _frontImage!,
      backImage: _backImage!,
    );

    setState(() {
      _isLoading = false;
    });

    // After receiving the response, navigate to the next page.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No app bar per requirements.
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image.
          Image.asset('assets/bg.png', fit: BoxFit.cover),
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
                // Welcome text.
                Center(
                  child: Text(
                    'Welcome Shubh,\nLets recycle for the present!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Add Picture header.
                Center(
                  child: Text(
                    'Add Picture',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // TextBox-like design for uploading front face.
                GestureDetector(
                  onTap: _pickFrontImage,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child:
                        _frontImage != null
                            ? Image.file(
                              _frontImage!,
                              height: 60,
                              fit: BoxFit.contain,
                            )
                            : Row(
                              children: [
                                Icon(Icons.camera_alt, color: Colors.black),
                                SizedBox(width: 10),
                                Text(
                                  'Upload Front Face',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
                SizedBox(height: 15),
                // TextBox-like design for uploading back face.
                GestureDetector(
                  onTap: _pickBackImage,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child:
                        _backImage != null
                            ? Image.file(
                              _backImage!,
                              height: 60,
                              fit: BoxFit.contain,
                            )
                            : Row(
                              children: [
                                Icon(Icons.camera_alt, color: Colors.black),
                                SizedBox(width: 10),
                                Text(
                                  'Upload Back Face',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
                SizedBox(height: 30),
                // Verify button.
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _verifyPhotos,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      side: BorderSide(color: Colors.black),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            )
                            : Text(
                              'Verify',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
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
