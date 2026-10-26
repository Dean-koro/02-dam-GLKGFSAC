import 'package:flutter/material.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer (const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront, color: Colors.white,),
            SizedBox(height: 30,),
            Text("Gatronomia de Quintana Roo",
            style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        )
      ),
    );
  }
}
