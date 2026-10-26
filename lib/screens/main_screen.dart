import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/favoritos_screen.dart';
import '../screens/acerca_de_screen.dart';

class MainScreen extends StatefulWidget {
    const MainScreen({super.key});

    @override 
    State<MainScreen> createState() => _MainScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _indiceActual=0;
  final List<Widget> _pantallas = const [
    HomeScreen(),
    FavoritosScreen(),
    AcercaDeScreen(),
  ];
    @override
    void _cambiarPantalla(int index) {
        setState(() {
            _indiceActual=index;
        })
    }
    @overide
    Widget build(BuildContext context) {
        return Scaffolf(
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
          ]
        )
        );
    }
}

