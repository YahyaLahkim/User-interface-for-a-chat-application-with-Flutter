import 'package:flutter/material.dart';
import '../models/call_model.dart';
import '../models/user_model.dart';

class CallItem extends StatelessWidget {
  final Call call;
  final User user;
  final VoidCallback? onVideoCall;
  final VoidCallback? onVoiceCall;

  const CallItem({
    Key? key,
    required this.call,
    required this.user,
    this.onVideoCall,
    this.onVoiceCall,
  }) : super(key: key);

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
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getCallDescription() {
    final time = '${call.timestamp.hour}:${call.timestamp.minute.toString().padLeft(2, '0')}';
    final duration = call.duration.inSeconds > 0
        ? '${call.duration.inMinutes}:${(call.duration.inSeconds % 60).toString().padLeft(2, '0')}'
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
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.avatar),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(user.name),
      subtitle: Text(
        _getCallDescription(),
        style: TextStyle(color: _getCallColor()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.videocam,
              color: Colors.blue,
            ),
            onPressed: onVideoCall,
          ),
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: onVoiceCall,
          ),
        ],
      ),
      onTap: onVoiceCall, // Appel vocal par défaut au tap
    );
  }
}