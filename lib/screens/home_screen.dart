import 'package:flutter/material.dart';
import '../models/recetas.dart';
import '../service/recetas_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecetasService _recetasService = RecetasService();
  late Future<List<Receta>> _futureRecetas;

  @override
  void initState() {
    super.initState();
    _futureRecetas = _recetasService.obtenerRecetas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastronomía de Quintana Roo'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Receta>>(
        future: _futureRecetas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error al cargar: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay recetas disponibles.'),
            );
          } else {
            final List<Receta> recetas = snapshot.data!;

            return ListView.builder(
              itemCount: recetas.length,
              itemBuilder: (context, index) {
                final receta = recetas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        receta.imagenUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    title: Text(receta.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${receta.cocina} • ${receta.dificultad}'),
                    trailing: IconButton(
                      icon: Icon(
                        receta.esFavorito ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          receta.esFavorito = !receta.esFavorito;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}