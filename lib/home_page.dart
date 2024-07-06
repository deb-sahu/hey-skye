import 'dart:async';
import 'package:hey_skye/chat_page.dart';
import 'package:hey_skye/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGifPlaying = true;
  late Timer _timer;

  void _toggleGif() {
    setState(() {
      _isGifPlaying = !_isGifPlaying;
    });

    if (_isGifPlaying) {
      _timer = Timer(const Duration(seconds: 4, microseconds: 10), () {
        setState(() {
          _isGifPlaying = false;
        });
      });
    } else {
      _timer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 4, microseconds: 10), () {
      setState(() {
        _isGifPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.gear_alt_fill),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                  onTap: _toggleGif,
                  child: _isGifPlaying
                      ? Image.asset(
                          'assets/pet-robot.gif',
                          width: 200,
                          height: 200,
                        )
                      : Image.asset(
                          'assets/pet-robot.png',
                          width: 140,
                          height: 200,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Hey there, I\'m Skye',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your friendly AI pet assistant, wooof!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text('Start Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
