import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'call_page.dart';
import 'profile_page.dart';
import '../services/mock_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final MockService _mockService = MockService();

  final List<Widget> _pages = [
    ChatListPage(),
    CallHistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'Messages' :
          _currentIndex == 1 ? 'Appels' : 'Profil',
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Appels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class ChatListPage extends StatelessWidget {
  final MockService _mockService = MockService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _mockService.users.length,
      itemBuilder: (context, index) {
        final user = _mockService.users[index];
        final messages = _mockService.getMessages(user.id);
        final lastMessage = messages.isNotEmpty ? messages.last : null;

        return ListTile(
          leading: CircleAvatar(
            child: Text(user.avatar),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            lastMessage?.content ?? 'Aucun message',
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (lastMessage != null)
                Text(
                  '${lastMessage.timestamp.hour}:${lastMessage.timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              if (user.isOnline)
                Container(
                  margin: EdgeInsets.only(top: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(user: user),
              ),
            );
          },
        );
      },
    );
  }
}