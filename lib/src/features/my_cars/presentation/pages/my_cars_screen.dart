import 'package:flutter/material.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('My Cars Screen')),
    );
  }
}
