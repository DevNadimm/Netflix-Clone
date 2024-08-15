import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logo/netflix_logo.png",
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
              child: Center(
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
        centerTitle: false,
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
