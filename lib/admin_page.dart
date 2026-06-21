import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("BGF Admin Panel"),
      ),

      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [

          AdminCard(
            icon: Icons.people,
            title: "Users",
          ),

          AdminCard(
            icon: Icons.forum,
            title: "Posts",
          ),

          AdminCard(
            icon: Icons.poll,
            title: "Polls",
          ),

          AdminCard(
            icon: Icons.campaign,
            title: "Notice",
          ),

          AdminCard(
            icon: Icons.settings,
            title: "Settings",
          ),

          AdminCard(
            icon: Icons.analytics,
            title: "Reports",
          ),
        ],
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const AdminCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 45,
            color: Colors.amber,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
