import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Photo de profil
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue[100],
            child: Text(
              '👤',
              style: TextStyle(fontSize: 40),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Yahya Lahkim',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'yahya@email.com',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 32),

          // Informations du compte
          _buildProfileSection(
            title: 'Informations du compte',
            children: [
              _buildProfileItem(
                icon: Icons.person,
                title: 'Modifier le profil',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.email,
                title: 'Changer l\'email',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.lock,
                title: 'Changer le mot de passe',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: 24),

          // Paramètres
          _buildProfileSection(
            title: 'Paramètres',
            children: [
              _buildProfileItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.security,
                title: 'Confidentialité',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.storage,
                title: 'Stockage et données',
                onTap: () {},
              ),
            ],
          ),

          SizedBox(height: 24),

          // Actions
          _buildProfileSection(
            title: 'Actions',
            children: [
              _buildProfileItem(
                icon: Icons.help,
                title: 'Aide',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.info,
                title: 'À propos',
                onTap: () {},
              ),
              _buildProfileItem(
                icon: Icons.logout,
                title: 'Déconnexion',
                onTap: () {},
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
      onTap: onTap,
    );
  }
}