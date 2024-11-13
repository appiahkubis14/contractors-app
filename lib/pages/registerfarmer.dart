import 'dart:io';
import 'package:contractapp/pages/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class RegisterFarmerPage extends StatefulWidget {
  const RegisterFarmerPage({super.key});

  @override
  _RegisterFarmerPageState createState() => _RegisterFarmerPageState();
}

class _RegisterFarmerPageState extends State<RegisterFarmerPage> {
  final _formKey = GlobalKey<FormState>(); // Key to validate the form
  String _selectedGender = 'Male';
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactnumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  void _registerFarmer() async {
    if (_formKey.currentState!.validate()) {
      String fullName = _fullNameController.text.trim();
      String contactNumber = _contactnumberController.text.trim();
      String email = _emailController.text.trim();
      String address = _addressController.text.trim();
      String dateOfBirth = _dateOfBirthController.text.trim();
      String gender = _selectedGender;
      String imagePath = _selectedImage?.path ?? '';

      ApiService apiService = ApiService();
      var result = await apiService.registerFarmer(
          fullName, dateOfBirth,gender, contactNumber,email,address, imagePath);

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Farmer registered successfully')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result['message'])));
      }
    }
  }

  void _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Farmer",
            style: TextStyle(fontFamily: 'Poppins', fontSize: 20,fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),

              // Personal Information Section
              const Text(
                'Personal Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00754B)),
              ),
              const SizedBox(height: 10),

              // Full Name
              _buildLabel('Full Name'),
              _buildTextField(_fullNameController, "Enter full name",
                  "Please enter your full name"),
              const SizedBox(height: 10),

              // Date of Birth
              _buildLabel('Date of Birth'),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  hintText: "Select date of birth",
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _dateOfBirthController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Gender
              _buildLabel('Gender'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male',style: TextStyle(fontFamily: 'Poppins'),),
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      activeColor: Color(0xFF00754B),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female',style: TextStyle(fontFamily: 'Poppins'),),
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                       activeColor: Color(0xFF00754B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Contact Number
              _buildLabel('Contact Number'),
              _buildTextField(_contactnumberController, "Enter contact number",
                  "Please enter a contact number"),
              const SizedBox(height: 10),

              // Email
              _buildLabel('Email'),
              _buildTextField(_emailController, "Enter your email",
                  "Please enter email"),
              const SizedBox(height: 10),

               _buildLabel('Address'),
              _buildTextField(_addressController, "Enter your address",
                  "Please enter address"),
              const SizedBox(height: 10),

              // Photo Section
              const Text(
                'Upload Photo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00754B)),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _takePhoto,
                child: Align(
                  alignment: Alignment.center,
                  child: _selectedImage != null
                      ? Image.file(_selectedImage!, width: 200, height: 100)
                      : Image.asset('assets/images/camera.png', width: 130),
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF00754B),
                  ),
                  onPressed: _registerFarmer, // Call the register method
                  child: const Text('Register',
                  style: TextStyle(fontFamily: 'Poppins',fontSize: 
                  15) ,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, String validationMessage) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}