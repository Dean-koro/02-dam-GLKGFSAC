import 'package:flutter/material.dart';

import '../models/recetas.dart';
import '../service/recetas_service.dart';
import 'detalle_receta_screen.dart';

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

  Future<void> _recargarRecetas() async {
    setState(() {
      _futureRecetas = _recetasService.obtenerRecetas();
    });
  }

  // NUEVO: abre el detalle y, al regresar, actualiza el favorito
  Future<void> _abrirDetalle(Receta receta) async {
    final bool? esFavorita = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleRecetaScreen(receta: receta),
      ),
    );

    if (!mounted) return;

    // El detalle modifica receta.esFavorito directamente; refrescamos siempre.
    setState(() {
      if (esFavorita != null) receta.esFavorito = esFavorita;
    });
  }

  void _mostrarMensajeTemporal() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.teal.shade900,
        content: const Text(
          "El mapa de los pueblos originarios se está abriendo",
          style: TextStyle(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Platillos ancestrales de Quintana Roo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 2),
            Text(
              'llevando el sazón a tu mano',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarMensajeTemporal,
        backgroundColor: Colors.teal.shade700,
        child: const Icon(Icons.map_outlined, color: Colors.white),
      ),
      body: FutureBuilder<List<Receta>>(
        future: _futureRecetas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off_rounded,
                      size: 48,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Error al cargar: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _recargarRecetas,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No hay recetas disponibles.'),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _recargarRecetas,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Actualizar'),
                  ),
                ],
              ),
            );
          } else {
            final List<Receta> recetas = snapshot.data!;

            return RefreshIndicator(
              color: Colors.teal.shade700,
              onRefresh: _recargarRecetas,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                // +1 para la tarjeta de bienvenida de arriba
                itemCount: recetas.length + 1,
                itemBuilder: (context, index) {
                  // Posición 0: tarjeta de bienvenida
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade800, Colors.teal.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade900.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.local_dining_rounded,
                            size: 48,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "El mejor chef que puedes tener eres tú mismo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Descubre los mejores platillos autóctonos, tradiciones culinarias y el sazón caribeño en un solo lugar.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Posiciones 1 en adelante: recetas
                  final receta = recetas[index - 1];

                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                    clipBehavior:
                        Clip.antiAlias, // NUEVO: para el efecto al tocar
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      // NUEVO: tocar la tarjeta abre el detalle
                      onTap: () => _abrirDetalle(receta),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                receta.imagenUrl,
                                width: 85,
                                height: 85,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 85,
                                      height: 85,
                                      color: Colors.teal.shade50,
                                      child: Icon(
                                        Icons.restaurant,
                                        color: Colors.teal.shade700,
                                        size: 36,
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    receta.nombre,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.restaurant_menu,
                                        size: 14,
                                        color: Colors.teal.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          receta.cocina,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade700,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bar_chart_rounded,
                                        size: 14,
                                        color: Colors.orange.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        receta.dificultad,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              iconSize: 26,
                              icon: Icon(
                                receta.esFavorito
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  receta.esFavorito = !receta.esFavorito;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
