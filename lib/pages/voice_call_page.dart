import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'video_call_page.dart';
import '../main.dart'; // pour récupérer les couleurs globales

class VoiceCallPage extends StatefulWidget {
  final User user;

  const VoiceCallPage({super.key, required this.user});

  @override
  _VoiceCallPageState createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  Duration _callDuration = const Duration(seconds: 00);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _callDuration = Duration(seconds: _callDuration.inSeconds + 1);
      });
      _startTimer();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyApp.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // En-tête
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    'Appel en cours',
                    style: TextStyle(color: MyApp.textColor, fontSize: 16),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Contenu principal
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.blue[100],
                    backgroundImage: AssetImage(widget.user.avatar),
                    child: widget.user.avatar.isEmpty
                      ? const Text(
                          "?",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        )
                      : null,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.user.name,
                    style: TextStyle(
                      color: MyApp.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.user.isOnline ? 'En ligne' : 'Hors ligne',
                    style: TextStyle(color: MyApp.unselectedColor, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    _formatDuration(_callDuration),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),

            // Boutons de contrôle principaux
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCallControlButton(
                    icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                    label: 'Haut-parleur',
                    isActive: _isSpeakerOn,
                    activeColor: MyApp.primaryColor,
                    onPressed: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                  ),
                  _buildCallControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: 'Muet',
                    isActive: _isMuted,
                    activeColor: MyApp.primaryColor,
                    onPressed: () => setState(() => _isMuted = !_isMuted),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: const Icon(Icons.call_end, size: 24),
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),

            // Boutons secondaires
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSecondaryButton(
                    icon: Icons.videocam,
                    label: 'Vidéo',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoCallPage(user: widget.user),
                        ),
                      );
                    },
                  ),
                  _buildSecondaryButton(
                    icon: Icons.person_add,
                    label: 'Ajouter',
                    onPressed: () {},
                  ),
                  _buildSecondaryButton(
                    icon: Icons.pause,
                    label: 'Pause',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isActive ? activeColor : Colors.white30,
          child: IconButton(
            icon: Icon(icon, size: 24),
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white30,
          child: IconButton(
            icon: Icon(icon, size: 20),
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
