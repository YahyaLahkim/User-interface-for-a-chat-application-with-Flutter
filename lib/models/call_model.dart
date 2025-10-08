class Call {
  final String id;
  final String callerId;
  final String receiverId;
  final DateTime timestamp;
  final CallType type;
  final CallStatus status;
  final Duration duration;

  Call({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.timestamp,
    required this.type,
    required this.status,
    required this.duration,
  });
}

enum CallType {
  voice,
  video,
}

enum CallStatus {
  missed,
  received,
  dialed,
}