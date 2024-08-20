import 'package:flutter/material.dart';

class TrendingPostWidget extends StatelessWidget {
  const TrendingPostWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.month,
    required this.description,
  });

  final String month;
  final String date;
  final String imageUrl;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(imageUrl),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        'assets/logo/netflix_logo.png',
                        height: 25,
                      ),
                      Spacer(),
                      _buildActionButton(
                        icon: Icons.notifications_none_rounded,
                        label: 'Remind Me',
                      ),
                      SizedBox(width: 20),
                      _buildActionButton(
                        icon: Icons.info_outline_rounded,
                        label: 'Info',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label}) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.white70),
        ),
      ],
    );
  }
}
