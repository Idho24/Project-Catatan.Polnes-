import 'package:flutter/material.dart';

class LayarDetail extends StatelessWidget {
  final String id;
  const LayarDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Catatan')),
      body: Center(child: Text('ID: $id')),
    );
  }
}
