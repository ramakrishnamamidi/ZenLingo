import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/zen_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ZenApp()));
}

class ZenApp extends StatelessWidget {
  const ZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenLingo',
      debugShowCheckedModeBanner: false,
      theme: ZenTheme.dark,
      home: const _NavShell(),
    );
  }
}

class _NavShell extends StatefulWidget {
  const _NavShell();

  @override
  State<_NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<_NavShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    _PlaceholderPage(label: '今日'),
    _PlaceholderPage(label: '辞書'),
    _PlaceholderPage(label: '練習'),
    _PlaceholderPage(label: '私'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: ZenTheme.bgBlack,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.local_fire_department), label: ''),
          NavigationDestination(icon: Icon(Icons.book_outlined), label: ''),
          NavigationDestination(icon: Icon(Icons.edit_outlined), label: ''),
          NavigationDestination(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
