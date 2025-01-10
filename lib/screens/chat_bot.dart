import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  String query = '';
  List<Map<String, String>> messages = [
    {'text': 'Hi, how can I help you today?', 'type': 'ai'},
  ];

  final String apiKey = 'YOUR_GEMINI_API_KEY'; // Replace with your API key
  final TextEditingController _controller = TextEditingController();

  Future<void> chat() async {
    if (query.isEmpty) return;

    setState(() {
      messages.add({'text': query, 'type': 'user'});
    });

    // Clear the text field
    _controller.clear();

    try {
      final url = Uri.parse('https://your-api-endpoint');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'prompt': query,
          'model': 'gemini-1.5-flash',
          'system_instruction': 'Your system instruction here',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final String aiResponse = data['response']['text']?.toString() ??
            'Sorry, I couldn\'t understand that.';

        setState(() {
          messages.add({'text': aiResponse, 'type': 'ai'});
        });
      } else {
        setState(() {
          messages.add({
            'text': 'Quickbot AI offline! Please try again later.',
            'type': 'ai'
          });
        });
      }
    } catch (error) {
      setState(() {
        messages.add(
            {'text': 'An error occurred. Please try again.', 'type': 'ai'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quickbot',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isAi = message['type'] == 'ai';

                  return Align(
                    alignment:
                        isAi ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isAi ? Colors.grey[200] : Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                          color: isAi ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Use the controller here
                    onChanged: (value) {
                      query = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: chat,
                  color: Colors.red[700],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
