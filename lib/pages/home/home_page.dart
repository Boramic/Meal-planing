import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        backgroundColor: const Color(0xFF2E7D32), // calm smooth green
        centerTitle: true,
        title: const Text(
          'Meal Planning',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              // later: open drawer or menu
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Home Page Content',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
