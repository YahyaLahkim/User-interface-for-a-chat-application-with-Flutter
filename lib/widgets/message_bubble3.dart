import 'dart:io'; // AJOUT
import 'package:flutter/material.dart';
import '../models/message_model3.dart';
import '../main.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final String senderAvatar;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.senderAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(senderAvatar),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: BoxConstraints(
                maxWidth: 280, // Largeur max
              ),
              decoration: BoxDecoration(
                color: _getBubbleColor(),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft:
                  isMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight:
                  isMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: _buildMessageContent(),
            ),
          ),

          if (isMe) const SizedBox(width: 8),

          if (isMe)
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(senderAvatar),
            ),
        ],
      ),
    );
  }

  // NOUVELLE MÉTHODE: Construit le contenu du message
  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.image:
        return _buildImageMessage();
      case MessageType.text:
      default:
        return _buildTextMessage();
    }
  }

  // MÉTHODE: Pour afficher une image
  Widget _buildImageMessage() {
    //if (message.filePath == null || message.filePath!.isEmpty) {
    //  return _buildErrorWidget("Image non disponible");
    //}

    try {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            //child: Image.file(
              //File(message.filePath!),
              //width: 250,
              //height: 200,
              //fit: BoxFit.cover,
              //errorBuilder: (context, error, stackTrace) {
              //  return _buildErrorWidget("Erreur de chargement");
              //},
            //),
          ),
          // Légende sous l'image (si présente)
          if (message.content.isNotEmpty && message.content != "📷 Image")
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      );
    } catch (e) {
      return _buildErrorWidget("Erreur d'affichage");
    }
  }

  // MÉTHODE: Pour afficher du texte
  Widget _buildTextMessage() {
    return Text(
      message.content,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }

  // MÉTHODE: Widget d'erreur
  Widget _buildErrorWidget(String errorText) {
    return Container(
      width: 250,
      height: 200,
      color: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, color: Colors.grey[400], size: 40),
          SizedBox(height: 8),
          Text(
            errorText,
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  // MÉTHODE: Couleur de la bulle
  Color _getBubbleColor() {
    if (message.type == MessageType.image) {
      return isMe 
          ? MyApp.primaryColor.withOpacity(0.8)
          : Colors.grey[850]!.withOpacity(0.8);
    }
    return isMe ? MyApp.primaryColor : Colors.grey[850]!;
  }
}