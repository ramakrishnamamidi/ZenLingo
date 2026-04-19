import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/zen_theme.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/srs/screens/review_screen.dart';
import 'features/writing/screens/writing_screen.dart';

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

class _NavShell extends ConsumerStatefulWidget {
  const _NavShell();

  @override
  ConsumerState<_NavShell> createState() => _NavShellState();
}

class _NavShellState extends ConsumerState<_NavShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    DashboardScreen(),                    // tab 0: 今日
    _PlaceholderPage(label: '辞書'),      // tab 1: Dictionary — Phase 4
    WritingScreen(),                      // tab 2: 練習
    _PlaceholderPage(label: '私'),        // tab 3: Profile — Phase 5
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_index],
          if (_index == 0)
            Positioned(
              bottom: 80,
              right: 16,
              child: FloatingActionButton.extended(
                backgroundColor: ZenTheme.accentRed,
                foregroundColor: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReviewScreen()),
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Review'),
              ),
            ),
        ],
      ),
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
