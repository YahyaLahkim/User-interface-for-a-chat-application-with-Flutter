import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/message_model3.dart';

class ApiService {
  // IMPORTANT : Changez cette URL selon votre configuration
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  
  // ID de l'utilisateur actuel (en dur pour le moment)
  static const String currentUserId = '6';

  // Récupérer tous les utilisateurs
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors du chargement des utilisateurs');
      }
    } catch (e) {
      print('Erreur getUsers: $e');
      throw Exception('Impossible de charger les utilisateurs');
    }
  }

  // Récupérer un utilisateur par ID
  Future<User> getUser(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Utilisateur non trouvé');
      }
    } catch (e) {
      print('Erreur getUser: $e');
      throw Exception('Impossible de charger l\'utilisateur');
    }
  }

  // Récupérer la conversation avec un utilisateur
  Future<List<Message>> getConversation(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/messages/$userId?current_user_id=$currentUserId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Erreur lors du chargement des messages');
      }
    } catch (e) {
      print('Erreur getConversation: $e');
      throw Exception('Impossible de charger la conversation');
    }
  }

  // Envoyer un message
  Future<Message> sendMessage({
    required String receiverId,
    required String content,
    String type = 'text',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/messages'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'sender_id': currentUserId,
          'receiver_id': receiverId,
          'content': content,
          'type': type,
        }),
      );

      if (response.statusCode == 201) {
        return Message.fromJson(json.decode(response.body));
      } else {
        throw Exception('Erreur lors de l\'envoi du message');
      }
    } catch (e) {
      print('Erreur sendMessage: $e');
      throw Exception('Impossible d\'envoyer le message');
    }
  }

  // Marquer un message comme lu
  Future<void> markAsRead(String messageId) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/messages/$messageId/read'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      print('Erreur markAsRead: $e');
    }
  }
}