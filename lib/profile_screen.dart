import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 15),

              // Name
              const Text(
                'Sara Khare',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // About Me
              const Text(
                'Hi! I am a Flutter developer passionate about creating beautiful and functional applications. I have a knack for learning new technologies.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Education Section
              _sectionTitle('Education'),
              _infoTile('Masters of Computer Application', 'SPIT, 2024 - 2026'),
              _infoTile('Bachelor of Computer Science',
                  'Mithibai College, 2020 - 2024'),
              _infoTile(
                  '12th Grade (HSC)', 'Narayana E-Techno School, 2018 - 2020'),
              _infoTile('10th Grade (ICSE)',
                  'Hiranandani Foundation School, 2017 - 2018'),

              const SizedBox(height: 20),

              // Certificates Section
              _sectionTitle('Certificates'),
              _infoTile('The Complete Oracle SQL Bootcamp', 'Udemy, 2024'),
              _infoTile('100 Days of Code: Python Pro Bootcamp', 'Udemy, 2024'),
              _infoTile('Data Analysis using Excel', 'Coursera, 2024'),
              _infoTile('The Complete PL/SQL Bootcamp', 'Udemy, 2024'),

              const SizedBox(height: 25),

              // Social Media Section
              _sectionTitle('Find Me On'),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(FontAwesomeIcons.linkedin, Colors.blue,
                      'https://linkedin.com/in/sara-khare'),
                  const SizedBox(width: 20),
                  _socialButton(FontAwesomeIcons.instagram, Colors.pink,
                      'https://www.instagram.com/sara.khareee'),
                  const SizedBox(width: 20),
                  _socialButton(FontAwesomeIcons.github, Colors.black,
                      'https://github.com/yourprofile'),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 180, 143, 204),
        ),
      ),
    );
  }

  // Information Tile
  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      leading:
          const Icon(Icons.school, color: Color.fromARGB(255, 180, 143, 204)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }

  // Social Media Button
  Widget _socialButton(IconData icon, Color color, String url) {
    return IconButton(
      icon: FaIcon(icon, color: color, size: 40),
      onPressed: () => _launchUrl(url),
    );
  }
}

// Drawer for navigation
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
              color: Color.fromARGB(255, 180, 143, 204),
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Register'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/register');
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Company Details'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/company');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
