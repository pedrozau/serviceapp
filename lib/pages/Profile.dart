import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/profile_provider.dart'; // Certifique-se de importar o ProfileProvider

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch user profile and transactions when the screen is loaded
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.fetchUserProfile();
    profileProvider.fetchUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: profileProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // User Profile Section
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 50.0,
                    child: Icon(Icons.person, size: 50.0, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Name: ${profileProvider.user?.name ?? "N/A"}',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Email: ${profileProvider.user?.email ?? "N/A"}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'NIF: ${profileProvider.user?.nif ?? "N/A"}', // Ajuste conforme o modelo
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Balance: \$${profileProvider.balance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Transaction History:',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  // Transaction History Section
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: profileProvider.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = profileProvider.transactions[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Transaction ${transaction.id}'),
                          subtitle: Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
