import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
  static const String apiKey = ''; // OpenAI API Key

   void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _isTyping = true;
      });

      String response = await _getResponse(_controller.text);

      setState(() {
        _messages.add(response);
        _isTyping = false;
        _controller.clear();
      });
    }
  }

  Future<String> _getResponse(String userMessage) async {
    try{
    const url = 'https://api.openai.com/v1/chat/completions';
    final response = await post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-16k',
        'messages': [
          {
            'role': 'system',
            'content': 'You are a helpful assistant.'
          },
          {
            'role': 'user',
            'content': userMessage
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      return 'Failed to get response. Please try again.';
    }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return 'Failed to get response. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Chat with Viya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background Image
          Center(
            child: Opacity(
              opacity: 0.1, // Opacity to blend the image
              child: Image.asset(
                'assets/technology.png',
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Chat Interface
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.grey[300] : Colors.blue[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(_messages[index]),
                      ),
                    );
                  },
                ),
              ),
              if (_isTyping)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(strokeWidth: 2),
                      const SizedBox(width: 10),
                      Text(
                        'Viya is typing...',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.paperclip, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(45 / 360),
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.paperplane_fill, color: Colors.white),
                            onPressed: _sendMessage,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}