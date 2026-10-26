import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de"),
        backgroundColor: Colors.blue,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Presentacion(),
            SizedBox(height: 28),
            _Integrantes(),
          ],
        ),
      ),
    );
  }
}

class _Presentacion extends StatelessWidget {
  const _Presentacion();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.restaurant_menu, size: 48, color: Colors.green),
        const SizedBox(height: 12),
        const Text(
          "Cocinado a fuego lento",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          "llevando el sazón a tu mano.",
          style: TextStyle(fontSize: 15, height: 1.5, color: Colors.grey[800]),
        ),
      ],
    );
  }
}

class _Integrantes extends StatelessWidget {
  const _Integrantes();

  static const List<String> _nombres = [
    "Jacson Esau Laines Mejia",
    "Uriel Antonio González Zurita",
    "Samiha Samiha Khalil Martínez",
    "Braulio Fernandez Peraza",
    "Andres Soto Garcia",
    "Edga balaam chim",
    "Jorge Gonzalez Mollinedo",
    "Ayotitla Aguayo Hussein Salvador",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Integrantes",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _nombres
              .map(
                (nombre) => Chip(
                  avatar: CircleAvatar(child: Text(nombre[0])),
                  label: Text(nombre),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
