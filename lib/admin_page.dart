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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [

            adminCard(Icons.people, "Users"),
            adminCard(Icons.forum, "Posts"),
            adminCard(Icons.poll, "Polls"),
            adminCard(Icons.campaign, "Notice"),
            adminCard(Icons.account_balance_wallet, "Deposit"),
            adminCard(Icons.money, "Withdraw"),
            adminCard(Icons.settings, "Settings"),
            adminCard(Icons.analytics, "Reports"),

          ],
        ),
      ),
    );
  }

  Widget adminCard(IconData icon, String title) {
    return Card(
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.amber,
            size: 45,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
