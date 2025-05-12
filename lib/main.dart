import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'company_details_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(TPOApp());
}

class TPOApp extends StatelessWidget {
  const TPOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TPO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 158, 143, 177),
      ),
      home: HomeScreen(),
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/company': (context) => CompanyDetailsPage(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TPO App'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/tpo_banner.jpg', height: 200),
            SizedBox(height: 20),
            Text(
              'About Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Our Training and Placement Office (TPO) helps students connect with top companies for internships and placements. We ensure professional growth and career opportunities for all students.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Email: tpo@example.com\nPhone: +91 9876543210\nAddress: Sardar Patel Insitute of Technology, Andheri West, Mumbai',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 158, 144, 180),
            ),
            child: Text(
              'TPO Navigation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Register'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Company Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyDetailsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
