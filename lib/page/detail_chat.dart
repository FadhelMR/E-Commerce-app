import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Penjual',
      'message': 'Segera pesan sebelum barang habis!',
      'isMe': false
    },
    {
      'text': 'You',
      'message': 'Terima kasih atas informasinya friend!',
      'isMe': true
    },
    {'text': 'Penjual', 'message': 'Sama-sam!', 'isMe': false},
  ];

  final TextEditingController _messageController = TextEditingController();

  // fungsi untuk mengirim pesan
  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add({'text': 'You', 'message': messageText, 'isMe': true});
      });
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactName),
      ),
      body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message['isMe'] == true;
            return ListTile(
              title: Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isMe
                        ? Colors.blueAccent
                        : const Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message['message']!,
                    style: TextStyle(color: isMe ? Colors.white : Colors.black),
                  ),
                ),
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                  hintText: 'Ketik Pesan...',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            )),
            IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.send),
              tooltip: 'Kirim pesan',
            )
          ],
        ),
      )),
    );
  }
}
