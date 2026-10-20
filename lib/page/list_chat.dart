import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  bool _showUndreadOnly = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        'name': 'Sahel Mulach',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30 PM',
        'avatarUrl': 'https://i.pravatar.cc/100?img=1',
        'isRead': 'false'
      },
      {
        'name': 'Suhail',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '00.00 AM',
        'avatarUrl': 'https://i.pravatar.cc/100?img=2',
        'isRead': 'true'
      },
      {
        'name': 'Fulan',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '15.00 PM',
        'avatarUrl': 'https://i.pravatar.cc/100?img=3',
        'isRead': 'false'
      },
      {
        'name': 'Yasser',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '15.20 PM',
        'avatarUrl': 'https://i.pravatar.cc/100?img=4',
        'isRead': 'true'
      },
      {
        'name': 'Wahyu',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '17.30 PM',
        'avatarUrl': 'https://i.pravatar.cc/100?img=5',
        'isRead': 'false'
      },
    ];

    final visibleChats = _showUndreadOnly
        ? chats.where((chat) => chat['isRead'] == false).toList()
        : chats;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat List',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: !_showUndreadOnly,
                  onSelected: (_) => setState(() {
                    _showUndreadOnly = false;
                  }),
                ),
                const SizedBox(
                  width: 8,
                ),
                ChoiceChip(
                  label: const Text('Belum dibaca'),
                  selected: _showUndreadOnly,
                  onSelected: (_) => setState(() {
                    _showUndreadOnly = true;
                  }),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: visibleChats.length,
                  itemBuilder: (context, index) {
                    final chat = visibleChats[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(chat['avatarUrl'] as String),
                      ),
                      title: Text(
                        chat['name'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(chat['lastMessage'] as String),
                      trailing: Text(chat['time'] as String),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail_chat',
                            arguments: {'contactName': chat['name'] as String});
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
