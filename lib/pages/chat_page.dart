import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import '../services/mock_service.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';
import 'video_call_page.dart'; // Ajout de l'import
import 'voice_call_page.dart'; // Ajout de l'import

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final MockService _mockService = MockService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    setState(() {
      _messages = _mockService.getMessages(widget.user.id);
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    await _mockService.sendMessage(widget.user.id, _messageController.text);
    _messageController.clear();
    _loadMessages();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Nouvelle méthode pour lancer un appel vidéo
  void _startVideoCall() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallPage(user: widget.user),
      ),
    );
  }

  // Nouvelle méthode pour lancer un appel vocal
  void _startVoiceCall() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoiceCallPage(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text(widget.user.avatar),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name),
                Text(
                  widget.user.isOnline ? 'En ligne' : widget.user.lastSeen,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Bouton d'appel vidéo
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _startVideoCall, // Appel de la nouvelle méthode
          ),
          // Bouton d'appel vocal
          IconButton(
            icon: Icon(Icons.call),
            onPressed: _startVoiceCall, // Appel de la nouvelle méthode
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  message: message,
                  isMe: message.senderId == 'current',
                );
              },
            ),
          ),
          ChatInput(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}