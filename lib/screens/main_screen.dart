import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favoritos_screen.dart';
import 'acerca_de_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override 
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _indiceActual = 0;
  
  // Quitamos 'const' de la lista para evitar errores si las pantallas usan estado
  final List<Widget> _pantallas = [
    const HomeScreen(),
    const FavoritosScreen(),
    const AcercaDeScreen(),
  ];

  void _cambiarPantalla(int index) {
    setState(() {
      _indiceActual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indiceActual,
        children: _pantallas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indiceActual,
        onTap: _cambiarPantalla,
        selectedItemColor: const Color.fromARGB(255, 255, 185, 239),
        unselectedItemColor: const Color.fromARGB(255, 163, 56, 131),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: "Favoritos"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Acerca de"
          ),
        ],
      ),
    );
  }
}