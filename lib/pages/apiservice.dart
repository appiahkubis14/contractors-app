import 'dart:convert';
import 'package:http/http.dart' as http; // Import http package

class ApiService {
  final String apiUrl = 'http://192.168.3.140:8000/api/'; // Set the base URL

  // Function to handle user login
  Future<bool> login(String username, String password) async {
    try {

      final response = await http.post(
        Uri.parse('${apiUrl}login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        // print("THE RESPONSE FROM THE SERVER 200 :::::::::::: ${response.body}");
        // Parse response if login is successful
        final data = jsonDecode(response.body);
        // You can store token or other data here if needed
        return true; // Login successful
      } else {
        // print("THE RESPONSE FROM THE SERVER FAILED :::::::::::: ${response.body}");
        // Handle error response
        print('Login failed: ${response.body}');
        return false; // Login failed
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }

  // Function to handle user signup
  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}contractors/'), // Cleaned URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body); // Success, return the response as a Map
      } else {
        throw Exception('Failed to signup');
      }
    } catch (e) {
      throw Exception('Failed to connect to API: $e');
    }
  }

  // Function to register the farmer
  Future<Map<String, dynamic>> registerFarmer(
    String fullName,
    String dateOfBirth,
    String gender,
    String contactNumber,
    String email,
    String address,
    String imagePath) async {
  try {
    final uri = Uri.parse('${apiUrl}farmers/'); // Use base URL for farmer registration

    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    request.fields['full_name'] = fullName;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['gender'] = gender;
    request.fields['contact_number'] = contactNumber;
    request.fields['email'] = email;
    request.fields['address'] = address;

    // Add image file if selected
    if (imagePath.isNotEmpty) {
      var imageFile = await http.MultipartFile.fromPath('photo', imagePath);
      request.files.add(imageFile);
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      final responseString = await response.stream.bytesToString();
      return {'success': true, 'message': 'Farmer registered successfully'};
    } else {
      final responseString = await response.stream.bytesToString();
      return {'success': false, 'message': jsonDecode(responseString)['message']};
    }
  } catch (e) {
    return {
      'success': false,
      'message': 'Error occurred: $e',
    };
  }
}

}