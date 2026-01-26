import 'package:flutter/material.dart';
import 'chat_page_old.dart';
//import 'call_page.dart';
//import 'profile_page.dart';
//import '../services/mock_service.dart';
import '../services/api_service_old.dart';
import '../models/user_model.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2; // onglet "Message" sélectionné par défaut


  final List<Widget> _pages = [
    HomeTab(),
    SearchTab(),
    MessageTab(),
    EventsTab(),
    ProfileTab(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}

class MessageTab extends StatefulWidget {
  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  bool isFriendsSelected = true;
  final ApiService _apiService = ApiService();
  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Charger les utilisateurs depuis l'API
  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final users = await _apiService.getUsers();
      setState(() {
        _users = users.where((user) => user.id != ApiService.currentUserId).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion au serveur';
        _isLoading = false;
      });
      print('Erreur lors du chargement des utilisateurs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // 🔹 Barre du haut
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MESSAGE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.group_add, color: Colors.blue),
                  label: Text("Create Group", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),

// 🔹 Boutons Friends / Group
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isFriendsSelected = true);
                  },
                  child: Column(
                    children: [
                      Text(
                        "Friends",
                        style: TextStyle(
                          color: isFriendsSelected ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: isFriendsSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (isFriendsSelected)
                        Container(
                          margin:  EdgeInsets.only(top: 4),
                          height: 2,
                          width: 60,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                )
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isFriendsSelected = false);
                  },
                  child: Column(
                    children: [
                      Text(
                        "Group",
                        style: TextStyle(
                          color: !isFriendsSelected ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: !isFriendsSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (!isFriendsSelected)
                        Container(
                          margin:  EdgeInsets.only(top: 4),
                          height: 2,
                          width: 60,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),


          // 🔹 Liste des messages
          if (isFriendsSelected)
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.blue))
                  : _errorMessage != null
                      ? Center(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      :RefreshIndicator(
                        onRefresh: _loadUsers,
                        child: ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(user.avatar),
                                radius: 25,
                              ),
                              title: Text(
                                user.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                user.isOnline ? 'En ligne' : 'Pas connecté(e)', //user.lastSeen,
                                style: TextStyle(
                                  color: user.isOnline
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("20:30",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  if(index %  2 == 0) //exemple de badge de notification
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "3",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(user: user),
                                  ),
                                );
                              },
                            );                          
                          },
                        ),

                      ),  
                      
            ),

          // Page Group
          if (!isFriendsSelected)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.group,
                      size: 80,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Create a Group",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// ------------------ Autres onglets ------------------
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text("Home", style: TextStyle(color: Colors.white)),
  );
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text("Search", style: TextStyle(color: Colors.white)),
  );
}

class EventsTab extends StatelessWidget {
  const EventsTab({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text("Events", style: TextStyle(color: Colors.white)),
  );
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text("Map", style: TextStyle(color: Colors.white)),
  );
}