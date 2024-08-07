import 'package:flutter/material.dart';
//import 'package:myapp/pages/Home.dart';
import 'package:myapp/pages/Login.dart';
import 'package:myapp/provider/auth_provider.dart';
import 'package:myapp/provider/profile_provider.dart';
import 'package:myapp/provider/service_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drawer and Bottom Navigation Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
