import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/seed.dart';
import 'providers.dart';
import 'screens/dashboard_screen.dart';
import 'screens/kasbon_screen.dart';
import 'screens/kasir_screen.dart';
import 'screens/lainnya_screen.dart';
import 'screens/stok_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: WarkopApp()));
}

class WarkopApp extends ConsumerStatefulWidget {
  const WarkopApp({super.key});
  @override
  ConsumerState<WarkopApp> createState() => _WarkopAppState();
}

class _WarkopAppState extends ConsumerState<WarkopApp> {
  int _boot = 0;
  String? _seedError;

  @override
  void initState() {
    super.initState();
    // UI langsung tampil; seed jalan di background dan tidak pernah
    // menahan splash. Kalau seed gagal, error ditampilkan, bukan macet.
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootDb());
  }

  Future<void> _bootDb() async {
    try {
      await seedAwal(ref.read(dbProvider))
          .timeout(const Duration(seconds: 20));
    } catch (e) {
      _seedError = '$e';
    }
    if (mounted) setState(() => _boot++);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warkop',
      theme: temaWarkop(Brightness.light),
      darkTheme: temaWarkop(Brightness.dark),
      // Key berubah setelah seed selesai -> layar query ulang, menu muncul.
      home: HomeNav(key: ValueKey(_boot), seedError: _seedError),
    );
  }
}

class HomeNav extends StatefulWidget {
  final String? seedError;
  const HomeNav({super.key, this.seedError});
  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _i = 0;
  // Tab yang pernah dibuka — hanya itu yang dibangun (lazy).
  final Set<int> _dibuka = {0};
  static const _labels = [
    'Beranda',
    'Jual',
    'Stok',
    'Bon',
    'Lainnya',
  ];
  static const _icons = [
    Icons.home,
    Icons.point_of_sale,
    Icons.inventory,
    Icons.book,
    Icons.grid_view,
  ];

  Widget _page(int k) {
    // Placeholder murah untuk tab yang belum pernah dibuka.
    if (!_dibuka.contains(k)) return const SizedBox.shrink();
    switch (k) {
      case 1:
        return const KasirScreen();
      case 2:
        return const StokScreen();
      case 3:
        return const KasbonScreen();
      case 4:
        return const LainnyaScreen();
      default:
        return const DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (widget.seedError != null)
            MaterialBanner(
              content: Text('DB gagal disiapkan: ${widget.seedError}'),
              actions: [TextButton(onPressed: () {}, child: const Text('OK'))],
            ),
          Expanded(
            child: IndexedStack(
              index: _i,
              children: [for (var k = 0; k < _labels.length; k++) _page(k)],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _i,
        onDestinationSelected: (v) => setState(() {
          _i = v;
          _dibuka.add(v);
        }),
        destinations: [
          for (var k = 0; k < _labels.length; k++)
            NavigationDestination(
                icon: Icon(_icons[k]), label: _labels[k]),
        ],
      ),
    );
  }
}
