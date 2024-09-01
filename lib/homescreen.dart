import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sys_monitor/monitor_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _url = TextEditingController();
  String? _error;
  Future<void> _checkURL() async {
    String url = _url.text;
    Uri uurl = Uri.parse(url);

    if (!uurl.isAbsolute) {
      setState(() {
        _error = 'Invalid URL';
      });
    }

    try {
      final response = await http.get(uurl);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('api_url', url);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => monitor(url: _url.text)));
      } else {
        setState(() {
          _error = 'Failed to reach server';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('System Monitor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(children: [
            Text('Enter API URL'),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type...',
                border: OutlineInputBorder(),
                errorText: _error,
              ),
              controller: _url,
            ),
            ElevatedButton(onPressed: _checkURL, child: Text('Done'))
          ]),
        ),
      ),
    );
  }
}
