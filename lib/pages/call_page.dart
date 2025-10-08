import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/mock_service.dart';
import '../widgets/call_item.dart';
import 'video_call_page.dart'; // Ajout de l'import
import 'voice_call_page.dart'; // Ajout de l'import

class CallHistoryPage extends StatelessWidget {
  final MockService _mockService = MockService();

  // Nouvelle méthode pour lancer un appel vidéo
  void _startVideoCall(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallPage(user: user),
      ),
    );
  }

  // Nouvelle méthode pour lancer un appel vocal
  void _startVoiceCall(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoiceCallPage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Actions rapides
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCallAction(
                icon: Icons.videocam,
                label: 'Vidéo',
                color: Colors.green,
                onTap: () {
                  // Lancer un appel vidéo avec le premier utilisateur
                  final user = _mockService.users.first;
                  _startVideoCall(context, user);
                },
              ),
              _buildCallAction(
                icon: Icons.call,
                label: 'Audio',
                color: Colors.blue,
                onTap: () {
                  // Lancer un appel vocal avec le premier utilisateur
                  final user = _mockService.users.first;
                  _startVoiceCall(context, user);
                },
              ),
              _buildCallAction(
                icon: Icons.contacts,
                label: 'Contacts',
                color: Colors.orange,
                onTap: () {
                  // Naviguer vers une page de contacts (à implémenter)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Page contacts à implémenter')),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(height: 1),
        // Historique des appels
        Expanded(
          child: ListView.builder(
            itemCount: _mockService.calls.length,
            itemBuilder: (context, index) {
              final call = _mockService.calls[index];
              final user = _mockService.getUser(
                call.callerId == 'current' ? call.receiverId : call.callerId,
              );
              return CallItem(
                call: call,
                user: user,
                onVideoCall: () => _startVideoCall(context, user),
                onVoiceCall: () => _startVoiceCall(context, user),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCallAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
            radius: 28,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}