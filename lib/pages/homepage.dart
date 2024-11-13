import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String contractorName;

  const HomePage({super.key, required this.contractorName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on the selected index
    if (index == 0) {
      // Navigate to home
      print("Home tapped");
    } else if (index == 1) {
      // Navigate to register farmer page
      Navigator.pushNamed(context, '/registerFarmer');
    } else if (index == 2) {
      // Navigate to settings
      print("Settings tapped");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",style: TextStyle(fontFamily: 'Poppins'),),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu,color: Color(0xFF00754B),),
              
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
    drawer: Drawer(
  child: ListView(
    children: <Widget>[
      DrawerHeader(
        decoration:const BoxDecoration(
          color:  Color(0xFF00754B), // Add a background color if you like
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/digging.png', width: 80, height: 80), // Display the image
            const SizedBox(height: 10),
            const Text(
              "Contractor Menu",
              style: TextStyle(fontFamily: 'Poppins',   fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ],
        ),
      ),
      ListTile(
        title: const Text("Profile", style: TextStyle(fontFamily: 'Poppins'),),
        onTap: () {
          // Handle navigation to profile page
        },
      ),
      ListTile(
        title: const Text("Settings", style: TextStyle(fontFamily: 'Poppins'),),
        onTap: () {
          // Handle navigation to settings
        },
      ),

      const SizedBox(height: 500,),
     // Logout button at the bottom
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity, // Make the button take full width
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCB343F), // Button color
              padding: const EdgeInsets.symmetric(vertical: 15,), // Adjust padding as needed
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontFamily: ' Poppins',fontSize: 16 ),
            ),
          ),
        ),
      ),
    ],
  ),
),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.contractorName}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              color: const Color(0xFF00754B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.person_add, color: Colors.white),
                title: const Text(
                  "Register Farmer",
                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/registerFarmer');
                },
              ),
            ),
            const SizedBox(height: 10),

            
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', 
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Register Farmer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
         selectedLabelStyle: const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: Colors.grey,
  ),
  selectedItemColor: const Color(0xFF00754B), // Green color for selected item
  unselectedItemColor: Colors.black, // Color for unselected items
      ),
    );
  }
}
