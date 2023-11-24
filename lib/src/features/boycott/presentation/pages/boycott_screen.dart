import 'package:flutter/material.dart';

class BoycottScreen extends StatefulWidget {
  const BoycottScreen({super.key});

  @override
  State<BoycottScreen> createState() => _BoycottScreenState();
}

class _BoycottScreenState extends State<BoycottScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Boycott Screen')),
    );
  }
}
