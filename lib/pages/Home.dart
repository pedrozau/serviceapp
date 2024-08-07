import 'package:flutter/material.dart';
import 'package:myapp/pages/Login.dart';
import 'package:myapp/pages/Profile.dart';
import 'package:myapp/pages/Service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/auth_provider.dart'; // Importe o seu AuthProvider aqui

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Styled Home Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Define the list of widget options for the BottomNavigationBar
  static List<Widget> _widgetOptions = <Widget>[
    ServiceScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to handle navigation from the Drawer
  void _onDrawerItemTapped(int index) {
    Navigator.pop(context); // Close the drawer
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    // Mostra um SnackBar para informar o sucesso do logout
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out successfully')),
    );

    // Remove o token e outras informações do usuário do SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove o token
    await prefs.remove('userId'); // Remove o ID do usuário

    // Notifique os provedores que o usuário foi desconectado, se necessário
    // Aqui você pode chamar métodos de logout em provedores, se necessário
    // Exemplo: Provider.of<ProfileProvider>(context, listen: false).logout();

    // Navegue para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BulirApp',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey[50],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Icon(Icons.person,
                          size: 50.0, color: Colors.blueAccent),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Welcome, User!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.work, color: Colors.blueAccent),
                title: Text('Service'),
                onTap: () {
                  _onDrawerItemTapped(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.blueAccent),
                title: Text('Profile'),
                onTap: () {
                  _onDrawerItemTapped(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.blueAccent),
                title: Text('Settings'),
                onTap: () {
                  _onDrawerItemTapped(2);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info, color: Colors.blueAccent),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Implement navigation or action for the "About" section
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.blueAccent),
                title: Text('Logout'),
                onTap: () {
                  _logout(); // Call the logout method
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Screen Content',
        style: TextStyle(fontSize: 24, color: Colors.blueAccent),
      ),
    );
  }
}
