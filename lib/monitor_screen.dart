import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sys_monitor/gauge.dart';

// ignore: camel_case_types
class monitor extends StatefulWidget {
  final String url;

  const monitor({super.key, required this.url});

  @override
  State<monitor> createState() => _monitorState();
}

// ignore: camel_case_types
class _monitorState extends State<monitor> {
  double cpu_usage = 0.0;
  double totalMemory = 10, usedMemory = 0, freeMemory = 0;
  double totalDisk = 10, usedDisk = 0, freeDisk = 0;
  // ignore: unused_field
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetch();
    refresh();
  }

  void fetch() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      final data = jsonDecode(response.body);
      setState(() {
        // cpu_usage = (data['cpu_usage_percentage']);
        // totalMemory = data['memory_usage']['total_mb'];
        // usedMemory = data['memory_usage']['used_mb'];
        // freeMemory = data['memory_usage']['free_mb'];
        // totalDisk = data['disk_usage']['total_mb'];
        // usedDisk = data['disk_usage']['used_mb'];
        // freeDisk = data['disk_usage']['free_mb'];
        cpu_usage = (data['cpu_usage_percentage'] as num).toDouble();
        totalMemory = (data['memory_usage']['total_mb'] as num).toDouble();
        usedMemory = (data['memory_usage']['used_mb'] as num).toDouble();
        freeMemory = (data['memory_usage']['free_mb'] as num).toDouble();
        totalDisk = (data['disk_usage']['total_mb'] as num).toDouble();
        usedDisk = (data['disk_usage']['used_mb'] as num).toDouble();
        freeDisk = (data['disk_usage']['free_mb'] as num).toDouble();
      });
    } catch (e) {
      print('Error $e');
    }
  }

  void refresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screensize = MediaQuery.of(context).size;

    final side = screensize.height * .3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Monitor'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: SizedBox(
                      width: side,
                      height: side,
                      child: gauge(title: 'CPU', max: 100, current: cpu_usage),
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: SizedBox(
                  width: side,
                  height: side,
                  child: gauge(
                      title: 'Memory Usage',
                      max: totalMemory,
                      current: usedMemory),
                ),
              ),
              SizedBox(
                child: SizedBox(
                  width: side,
                  height: side,
                  child: gauge(
                      title: 'Disk Usage', max: totalDisk, current: usedDisk),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
