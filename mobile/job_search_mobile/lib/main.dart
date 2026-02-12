import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String backendBaseUrl = 'http://localhost:8000';
// For emulator/device, we'll adjust later (10.0.2.2 for Android emulator etc.)

void main() {
  runApp(const JobSearchApp());
}

class JobSearchApp extends StatelessWidget {
  const JobSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Search Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _message = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchHello();
  }

  Future<void> _fetchHello() async {
    try {
      final response = await http.get(Uri.parse('$backendBaseUrl/hello'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          _message = data['message'] ?? 'No message';
        });
      } else {
        setState(() {
          _message = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Failed to connect: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Search Mobile')),
      body: Center(
        child: Text(
          'Backend says:\n$_message',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
