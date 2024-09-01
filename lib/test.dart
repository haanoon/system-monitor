import 'package:flutter/material.dart';

class HomeScreen22 extends StatelessWidget {
  const HomeScreen22({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Usage Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(children: [
            Text('Enter API URL'),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Type...', border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Done'))
          ]),
        ),
      ),
    );
  }
}
