import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key});

  final results = [
    {'student': 'Ana Maria', 'score': 8.5, 'date': '2025-06-01'},
    {'student': 'Bruno Silva', 'score': 7.0, 'date': '2025-06-02'},
    {'student': 'Carlos Eduardo', 'score': 9.0, 'date': '2025-06-03'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados das Provas')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) {
          final r = results[i];
          return ListTile(
            title: Text(style: const TextStyle(fontWeight: FontWeight.w600), ['student'] as String),
            subtitle: Text('Data: ${r['date']}'),
            trailing: Text(r['score'].toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          );
        },
      ),
    );
  }
}
