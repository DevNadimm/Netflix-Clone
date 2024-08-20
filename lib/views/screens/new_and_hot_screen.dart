import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('New & Hot'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.cast),
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
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: '  🍿 Coming Soon  ',
              ),
              Tab(text: '  🔥 Everyone\'s Watching  ')
            ],
          ),
        ),
        body: Center(
          child: Text("More Screen"),
        ),
      ),
    );
  }
}
