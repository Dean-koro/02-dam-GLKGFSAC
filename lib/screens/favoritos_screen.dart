import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        backgroundColor: Colors.blue,
      ),
      body: const _SinFavoritos(),
    );
  }
}

class _SinFavoritos extends StatelessWidget {
  const _SinFavoritos();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 72, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "Aún no tienes favoritos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Las recetas que guardes aparecerán aquí.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
