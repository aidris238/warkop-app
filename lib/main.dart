import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/seed.dart';
import 'providers.dart';
import 'screens/belanja_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/kasbon_screen.dart';
import 'screens/kasir_screen.dart';
import 'screens/masuk_screen.dart';
import 'screens/master_screen.dart';
import 'screens/pengeluaran_screen.dart';
import 'screens/stok_screen.dart';

void main() {
  runApp(const ProviderScope(child: WarkopApp()));
}

class WarkopApp extends ConsumerStatefulWidget {
  const WarkopApp({super.key});
  @override
  ConsumerState<WarkopApp> createState() => _WarkopAppState();
}

class _WarkopAppState extends ConsumerState<WarkopApp> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    seedAwal(ref.read(dbProvider)).then((_) {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warkop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E1F)),
        useMaterial3: true,
      ),
      home: _ready
          ? const HomeNav()
          : const Scaffold(
              body: Center(child: CircularProgressIndicator())),
    );
  }
}

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});
  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  int _i = 0;
  // Tab yang pernah dibuka — hanya itu yang dibangun (lazy).
  final Set<int> _dibuka = {0};
  static const _labels = [
    'Laporan',
    'Kasir',
    'Stok',
    'Belanja',
    'Masuk',
    'Keluar',
    'Kasbon',
    'Master',
  ];
  static const _icons = [
    Icons.dashboard,
    Icons.point_of_sale,
    Icons.inventory,
    Icons.shopping_cart,
    Icons.input,
    Icons.money_off,
    Icons.book,
    Icons.settings,
  ];

  Widget _page(int k) {
    // Placeholder murah untuk tab yang belum pernah dibuka.
    if (!_dibuka.contains(k)) return const SizedBox.shrink();
    switch (k) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const KasirScreen();
      case 2:
        return const StokScreen();
      case 3:
        return const BelanjaScreen();
      case 4:
        return const MasukScreen();
      case 5:
        return const PengeluaranScreen();
      case 6:
        return const KasbonScreen();
      default:
        return const MasterScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _i,
        children: [for (var k = 0; k < _labels.length; k++) _page(k)],
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
