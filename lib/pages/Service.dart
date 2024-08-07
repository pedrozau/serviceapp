import 'package:flutter/material.dart';
import 'package:myapp/model.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/service_provider.dart';
import 'package:myapp/pages/ServiceDetail.dart'; // Import the new details screen

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch services when the screen is loaded
    Provider.of<ServiceProvider>(context, listen: false).fetchServices();
  }

  // Function to contract a service
  Future<void> _contractService(Service service) async {
    // Implement your service contracting logic here
    print('Contracting service: ${service.title}');
    // Example code to simulate action
    // final response = await http.post(
    //   Uri.parse('https://api.example.com/contract'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: json.encode({'serviceId': service.id}),
    // );
    // If the response is successful, you can update the state or show a message
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: serviceProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: serviceProvider.services.length,
              itemBuilder: (context, index) {
                final service = serviceProvider.services[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                service.title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                service.description,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '\$${service.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () => _contractService(service),
                              child: Text('Contratar'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Colors.blueAccent, // Button text color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          serviceProvider.fetchServices();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
