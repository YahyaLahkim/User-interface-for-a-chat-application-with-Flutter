import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../main.dart'; // pour récupérer les couleurs globales

class VideoCallPage extends StatefulWidget {
  final User user;

  const VideoCallPage({super.key, required this.user});

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;

  @override
  Widget build(BuildContext context) {
    //final colors = MyApp;

    return Scaffold(
      backgroundColor: MyApp.backgroundColor,
      body: Stack(
        children: [
          // Vue caméra distante (simulée)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue[100],
                  backgroundImage: AssetImage(widget.user.avatar),
                  child: widget.user.avatar.isEmpty
                    ? const Text(
                              "?",
                              style: TextStyle(fontSize: 40, color: Colors.white),
                            )
                          : null,                 
                ),
                const SizedBox(height: 20),
                Text(
                  widget.user.name,
                  style: TextStyle(
                    color: MyApp.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Appel vidéo en cours...',
                  style: TextStyle(color: MyApp.unselectedColor),
                ),
                const SizedBox(height: 20),
                const Text(
                  '00:45',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          // Vue caméra locale
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: _isVideoOff
                  ? const Center(
                child: Icon(Icons.videocam_off, color: Colors.white, size: 40),
              )
                  : Image.asset('assets/images/yahya.jpg', fit: BoxFit.cover),
            ),
          ),

          // Boutons de contrôle
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Bouton muet
                _buildCallControlButton(
                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                  backgroundColor: _isMuted ? MyApp.primaryColor : Colors.white30,
                  iconColor: _isMuted ? MyApp.backgroundColor : Colors.white,
                  onPressed: () => setState(() => _isMuted = !_isMuted),
                ),

                // Bouton raccrocher
                _buildCallControlButton(
                  icon: Icons.call_end,
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),

                // Bouton caméra
                _buildCallControlButton(
                  icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                  backgroundColor: _isVideoOff ? MyApp.primaryColor : Colors.white30,
                  iconColor: _isVideoOff ? MyApp.backgroundColor : Colors.white,
                  onPressed: () => setState(() => _isVideoOff = !_isVideoOff),
                ),

                // Changement de caméra
                _buildCallControlButton(
                  icon: Icons.cameraswitch,
                  backgroundColor: Colors.white30,
                  iconColor: Colors.white,
                  onPressed: () => setState(() => _isFrontCamera = !_isFrontCamera),
                ),
              ],
            ),
          ),

          // Bouton retour
          Positioned(
            top: 40,
            left: 20,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallControlButton({
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: backgroundColor,
      child: IconButton(
        icon: Icon(icon, size: 24),
        color: iconColor,
        onPressed: onPressed,
      ),
    );
  }
}
