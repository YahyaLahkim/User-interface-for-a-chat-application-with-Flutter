import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import '../main.dart'; // pour récupérer les couleurs globales
import 'dart:io'; // AJOUT


class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final Function(File)? onImageSelected;
  

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    this.onImageSelected, // NOUVEAU: paramètre optionnel
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyApp.backgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        children: [
          // Bouton d'attachement
          IconButton(
            icon: Icon(Icons.attach_file, color: MyApp.unselectedColor),
            onPressed: null, // Désactivé pour l'instant
          ),

          // Champ de texte
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: MyApp.textColor),
              decoration: InputDecoration(
                hintText: 'Tapez un message...',
                hintStyle: TextStyle(color: MyApp.unselectedColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[850], // gris foncé pour s'harmoniser au thème
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          // Bouton d'envoi
          IconButton(
            icon: Icon(Icons.send, color: MyApp.primaryColor),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
