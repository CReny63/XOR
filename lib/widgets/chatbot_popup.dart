// lib/widgets/chatbot_popup.dart

import 'package:flutter/material.dart';

class ChatbotPopup extends StatefulWidget {
  const ChatbotPopup({Key? key}) : super(key: key);

  @override
  State<ChatbotPopup> createState() => _ChatbotPopupState();
}

class _ChatbotPopupState extends State<ChatbotPopup> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bart'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,  // Adjust to your preference
        height: MediaQuery.of(context).size.height * 0.5, // Adjust to your preference
        child: Column(
          children: [
            // Display conversation history
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg.isBot
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: msg.isBot
                            ? Colors.grey.shade300
                            : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(msg.text),
                    ),
                  );
                },
              ),
            ),
            // Text Field + Send Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                    onSubmitted: (_) => _handleUserMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _handleUserMessage,
                ),
              ],
            ),
          ],
        ),
      ),
      // Close Button
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }

  void _handleUserMessage() {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    // Add user's message to chat
    setState(() {
      _messages.add(ChatMessage(text: userText, isBot: false));
    });

    // Clear input field
    _controller.clear();

    // Generate bot response
    final botReply = _getBotReply(userText);
    setState(() {
      _messages.add(ChatMessage(text: botReply, isBot: true));
    });
  }

  // Simple AI-like logic to respond
  String _getBotReply(String userInput) {
    final lowerCaseInput = userInput.toLowerCase();

    // Basic quick checks
    if (lowerCaseInput.contains('help') ||
        lowerCaseInput.contains('menu') ||
        lowerCaseInput.contains('what can i do')) {
      return _helpMenu();
    } else if (lowerCaseInput.contains('home')) {
      return 'To go to the Home Page, tap on the Home icon in the bottom navigation bar.';
    } else if (lowerCaseInput.contains('points') ||
               lowerCaseInput.contains('earn') ||
               lowerCaseInput.contains('rewards')) {
      return 'You can earn points by scanning the QR code at each Boba store. Collect enough to get rewards!';
    } else if (lowerCaseInput.contains('hi') ||
               lowerCaseInput.contains('hello') ||
               lowerCaseInput.contains('hey')) {
      return 'Hello! How can I help you today? Type "help" or "menu" for suggestions.';
    } else {
      // Generic small talk or default response
      return 'I see! If you need help or menu suggestions, just type "help" or "menu".';
    }
  }

  // Provide a menu of possible actions/commands
  String _helpMenu() {
    return '''
Here are some things I can help you with:
• "Home" to learn how to navigate back to the home screen.
• "Points" or "Earn" to see how you collect points at stores.
• You can also just chat with me about anything!
''';
  }
}

class ChatMessage {
  final String text;
  final bool isBot;

  ChatMessage({required this.text, required this.isBot});
}
