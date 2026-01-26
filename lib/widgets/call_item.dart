import 'package:flutter/material.dart';
import '../models/call_model.dart';
import '../models/user_model.dart';
import '../main.dart'; // pour récupérer les couleurs globales

class CallItem extends StatelessWidget {
  final Call call;
  final User user;
  final VoidCallback? onVideoCall;
  final VoidCallback? onVoiceCall;

  const CallItem({
    super.key,
    required this.call,
    required this.user,
    this.onVideoCall,
    this.onVoiceCall,
  });

  IconData _getCallIcon() {
    switch (call.type) {
      case CallType.video:
        return Icons.videocam;
      case CallType.voice:
      default:
        return Icons.call;
    }
  }

  Color _getCallColor() {

    switch (call.status) {
      case CallStatus.missed:
        return Colors.red;
      case CallStatus.received:
        return Colors.green;
      case CallStatus.dialed:
        return MyApp.primaryColor;
      default:
        return MyApp.unselectedColor;
    }
  }

  String _getCallDescription() {
    final time =
        '${call.timestamp.hour.toString().padLeft(2, '0')}:${call.timestamp.minute.toString().padLeft(2, '0')}';
    final duration = call.duration.inSeconds > 0
        ? '${call.duration.inMinutes.toString().padLeft(2, '0')}:${(call.duration.inSeconds % 60).toString().padLeft(2, '0')}'
        : '';

    switch (call.status) {
      case CallStatus.missed:
        return 'Appel manqué • $time';
      case CallStatus.received:
        return 'Entrant • $time ${duration.isNotEmpty ? '• $duration' : ''}';
      case CallStatus.dialed:
        return 'Sortant • $time ${duration.isNotEmpty ? '• $duration' : ''}';
      default:
        return '$time';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = MyApp;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(user.avatar),
        backgroundColor: Colors.grey[700],
      ),
      title: Text(
        user.name,
        style: TextStyle(color: MyApp.textColor),
      ),
      subtitle: Text(
        _getCallDescription(),
        style: TextStyle(color: _getCallColor()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.videocam, color: MyApp.primaryColor),
            onPressed: onVideoCall,
          ),
          IconButton(
            icon: Icon(Icons.call, color: Colors.green),
            onPressed: onVoiceCall,
          ),
        ],
      ),
      onTap: onVoiceCall,
    );
  }
}
