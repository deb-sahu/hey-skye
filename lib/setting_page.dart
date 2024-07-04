import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  double _fontSize = 16.0;
  bool _darkMode = false;

  void _clearAllData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade200,
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to clear all data?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('Clear', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All data cleared'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 15),
            ),
            trailing: Switch(
              inactiveThumbColor: Colors.grey.shade600,
              inactiveTrackColor: Colors.grey.shade300.withOpacity(0.5),
              activeColor: Colors.blueAccent,
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Dark Mode', style: TextStyle(fontSize: 15)),
            trailing: Switch(
              inactiveThumbColor: Colors.grey.shade600,
              inactiveTrackColor: Colors.grey.shade300.withOpacity(0.5),
              activeColor: Colors.blueAccent,
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Font Size', style: TextStyle(fontSize: 15)),
            subtitle: Slider(
              inactiveColor: Colors.grey.shade600,
              activeColor: Colors.blueAccent,
              value: _fontSize,
              min: 10.0,
              max: 24.0,
              divisions: 14,
              label: _fontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _clearAllData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                elevation: 5, // Elevation for a shadow effect
              ),
              child: const Text('Clear All Data', style: TextStyle(fontSize: 15)),
            ),
          ),
          
        ],
      ),
    );
  }
}
