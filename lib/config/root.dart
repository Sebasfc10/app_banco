import 'package:app_banca/presentation/screens/history_screen.dart';
import 'package:app_banca/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RootWidget extends StatefulWidget {
  int indexx;
  RootWidget({super.key, this.indexx = 0});

  @override
  _RootWidget createState() => _RootWidget();
}

class _RootWidget extends State<RootWidget> {
  //int _selectedIndex = 0;

  final List<Widget> _screens = [HomeScreen(), HistoryScreen()];

  void _onItemTapped(int index) {
    setState(() {
      widget.indexx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[widget.indexx],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.horizontal_split_rounded),
            label: 'Historial créditos',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 15.0,
        selectedItemColor: Color(0xff5428F1),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: widget.indexx,
        onTap: _onItemTapped,
      ),
    );
  }
}
