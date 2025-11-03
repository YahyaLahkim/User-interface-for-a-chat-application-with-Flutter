import 'package:flutter/material.dart';
import '../models/user_model.dart';

class VideoCallPage extends StatefulWidget {
  final User user;

  const VideoCallPage({Key? key, required this.user}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Vue de la caméra distante (simulée)
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
                  child: Text(
                    widget.user.avatar,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Appel vidéo en cours...',
                  style: TextStyle(color: Colors.white54),
                ),
                SizedBox(height: 20),
                Text(
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

          // Vue de la caméra locale (petite fenêtre)
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
                  ? Center(
                child: Icon(
                  Icons.videocam_off,
                  color: Colors.white,
                  size: 40,
                ),
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
                  backgroundColor: _isMuted ? Colors.white : Colors.white30,
                  iconColor: _isMuted ? Colors.black : Colors.white,
                  onPressed: () {
                    setState(() {
                      _isMuted = !_isMuted;
                    });
                  },
                ),

                // Bouton raccrocher
                _buildCallControlButton(
                  icon: Icons.call_end,
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                // Bouton caméra
                _buildCallControlButton(
                  icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                  backgroundColor: _isVideoOff ? Colors.white : Colors.white30,
                  iconColor: _isVideoOff ? Colors.black : Colors.white,
                  onPressed: () {
                    setState(() {
                      _isVideoOff = !_isVideoOff;
                    });
                  },
                ),

                // Bouton changement de caméra
                _buildCallControlButton(
                  icon: Icons.cameraswitch,
                  backgroundColor: Colors.white30,
                  iconColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isFrontCamera = !_isFrontCamera;
                    });
                  },
                ),
              ],
            ),
          ),

          // En-tête avec informations
          Positioned(
            top: 40,
            left: 20,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
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