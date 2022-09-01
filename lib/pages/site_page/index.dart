import 'package:flutter/material.dart';

class SitePage extends StatelessWidget {
  const SitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[900],
          title: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Site oficial"),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed("/avatar_page"),
                icon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
