import 'package:contractapp/pages/homepage.dart';
import 'package:contractapp/pages/login_page.dart';
import 'package:contractapp/pages/registerfarmer.dart';
import 'package:contractapp/pages/screens/splash_screen';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: const HomePage(contractorName: '',), 
       routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(contractorName: 'John Doe'),
         '/registerFarmer': (context) => const RegisterFarmerPage(), // Define the login route
        // You can define more routes here if needed, like '/home' or '/profile'
      },
    );
  }
}
