import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/pelanggan_bloc.dart';
import 'bloc/barang_bloc.dart';
import 'bloc/transaksi_bloc.dart';
import 'services/api_service.dart';
import 'pages/pelanggan_page.dart';
import 'pages/barang_page.dart';
import 'pages/transaksi_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PelangganCubit(ApiService())),
          BlocProvider(create: (context) => BarangCubit(ApiService())),
          BlocProvider(create: (context) => TransaksiCubit(ApiService())),
        ],
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PelangganPage(),
    BarangPage(),
    TransaksiPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pelanggan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Barang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Transaksi',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
