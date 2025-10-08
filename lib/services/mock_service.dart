import '../models/user_model.dart';
import '../models/message_model.dart';
import '../models/call_model.dart';

class MockService {
  static final MockService _instance = MockService._internal();
  factory MockService() => _instance;
  MockService._internal();

  // Utilisateurs mock
  final List<User> _users = [
    User(
      id: '1',
      name: 'Yahya',
      email: 'yahya@email.com',
      avatar: '👨', //👩
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '2',
      name: 'Mouad',
      email: 'moad@email.com',
      avatar: '👨',
      isOnline: false,
      lastSeen: 'Il y a 5 min',
    ),
    User(
      id: '3',
      name: 'Charline ',
      email: 'charlie@email.com',
      avatar: '👸',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '4',
      name: 'Houssam',
      email: 'Houssam@email.com',
      avatar: '👨',//🧑
      isOnline: false,
      lastSeen: 'Il y a 2h',
    ),
    User(
      id: '5',
      name: 'Emilio',
      email: 'emilio@email.com',
      avatar: '🧑',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '6',
      name: 'Floretin',
      email: 'Floretin@email.com',
      avatar: '🧑',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '7',
      name: 'Clement ',
      email: 'clement@email.com',
      avatar: '🧑',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '8',
      name: 'Sara ',
      email: 'sara@email.com',
      avatar: '👸',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
    User(
      id: '9',
      name: 'Salma ',
      email: 'Salma@email.com',
      avatar: '👸',
      isOnline: true,
      lastSeen: 'En ligne',
    ),
  ];

  // Messages mock avec réponses automatiques
  final Map<String, List<Message>> _conversations = {
    '1': [
      Message(
        id: '1',
        senderId: '1',
        receiverId: 'current',
        content: 'Bonjour ! Comment vas-tu ?',
        timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      ),
      Message(
        id: '2',
        senderId: 'current',
        receiverId: '1',
        content: 'Salut ! Je vais bien, merci. Et toi ?',
        timestamp: DateTime.now().subtract(Duration(minutes: 9)),
      ),
    ],
    '2': [
      Message(
        id: '1',
        senderId: '2',
        receiverId: 'current',
        content: 'Tu as vu le match hier soir ?',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
      ),
    ],
    '3': [
      Message(
        id: '1',
        senderId: 'current',
        receiverId: '3',
        content: 'On se voit demain ?',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
      ),
      Message(
        id: '2',
        senderId: '3',
        receiverId: 'current',
        content: 'Oui, à 15h ça te va ?',
        timestamp: DateTime.now().subtract(Duration(hours: 23)),
      ),
    ],
  };

  // Appels mock
  final List<Call> _calls = [
    Call(
      id: '1',
      callerId: '1',
      receiverId: 'current',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      type: CallType.voice,
      status: CallStatus.received,
      duration: Duration(minutes: 5),
    ),
    Call(
      id: '2',
      callerId: '2',
      receiverId: 'current',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      type: CallType.video,
      status: CallStatus.missed,
      duration: Duration.zero,
    ),
    Call(
      id: '3',
      callerId: 'current',
      receiverId: '3',
      timestamp: DateTime.now().subtract(Duration(days: 2)),
      type: CallType.voice,
      status: CallStatus.dialed,
      duration: Duration(minutes: 12),
    ),
  ];

  // Getters
  List<User> get users => _users;
  List<Call> get calls => _calls;

  List<Message> getMessages(String userId) {
    return _conversations[userId] ?? [];
  }

  // Envoyer un message et obtenir une réponse automatique
  Future<void> sendMessage(String userId, String content) async {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'current',
      receiverId: userId,
      content: content,
      timestamp: DateTime.now(),
    );

    if (!_conversations.containsKey(userId)) {
      _conversations[userId] = [];
    }
    _conversations[userId]!.add(newMessage);

    // Réponse automatique après un délai
    await Future.delayed(Duration(seconds: 1));

    final autoResponses = [
      "D'accord, je vois !",
      "Très intéressant !",
      "Je note ça 👍",
      "On en parle plus tard ?",
      "Merci pour l'info !",
      "Je suis d'accord avec toi",
      "C'est une bonne question",
      "Je reviens vers toi rapidement"
    ];

    final randomResponse = autoResponses[DateTime.now().millisecond % autoResponses.length];

    final responseMessage = Message(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      senderId: userId,
      receiverId: 'current',
      content: randomResponse,
      timestamp: DateTime.now().add(Duration(seconds: 1)),
    );

    _conversations[userId]!.add(responseMessage);
  }

  User getUser(String userId) {
    return _users.firstWhere((user) => user.id == userId);
  }
}