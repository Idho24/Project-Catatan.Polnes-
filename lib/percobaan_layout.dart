import 'package:flutter/material.dart';

class PercobaanLayout extends StatelessWidget {
  const PercobaanLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Percobaan')),
      body: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Judul catatan yang sangat panjang sekali',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.push_pin),
            ],
          ),
          Expanded(child: ListView(children: const [Text('a'), Text('b')])),
        ],
      ),
    );
  }
}
