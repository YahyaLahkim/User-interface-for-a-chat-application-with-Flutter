class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.type = MessageType.text,
    this.isRead = false,
  });

  // Convertir JSON en objet Message
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'].toString(),
      senderId: json['sender_id'].toString(),
      receiverId: json['receiver_id'].toString(),
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['created_at']),
      type: _parseMessageType(json['type']),
      isRead: json['is_read'] == 1 || json['is_read'] == true,
    );
  }

  // Convertir objet Message en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'created_at': timestamp.toIso8601String(),
      'type': type.toString().split('.').last,
      'is_read': isRead,
    };
  }

  // Méthode helper pour convertir le type
  static MessageType _parseMessageType(String? type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      default:
        return MessageType.text;
    }
  }
}

enum MessageType {
  text,
  image,
  video,
  audio,
}