// chatbot.dart
import 'package:flutter/material.dart';

class ChatbotPopup extends StatefulWidget {
  @override
  _ChatbotPopupState createState() => _ChatbotPopupState();
}

class _ChatbotPopupState extends State<ChatbotPopup> {
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = ["Hi! How can I help you navigate?"];

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add("You: $message");
      _messages.add("Bot: ${_getBotResponse(message)}");
    });
    _controller.clear();
  }

  String _getBotResponse(String message) {
    if (message.toLowerCase().contains("home")) {
      return "You are on the Home page!";
    } else if (message.toLowerCase().contains("profile")) {
      return "You can view your Profile in the profile section.";
    } else if (message.toLowerCase().contains("settings")) {
      return "You can adjust settings in the Settings section.";
    } else {
      return "Sorry, I didn't quite understand that. Can you rephrase?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Navigation Chatbot"),
      content: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: _messages[index].startsWith("You:")
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Bubble(
                        message: _messages[index],
                        isUserMessage: _messages[index].startsWith("You:"),
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
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}

class Bubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const Bubble({Key? key, required this.message, required this.isUserMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isUserMessage ? Colors.blueAccent : Colors.grey.shade300,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          message,
          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
