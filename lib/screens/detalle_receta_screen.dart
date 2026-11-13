import 'package:flutter/material.dart';
import 'package:app_gastro_v1/models/recetas.dart';
import 'package:app_gastro_v1/models/resena.dart'; // NUEVO
import 'package:app_gastro_v1/service/resenas_service.dart'; // NUEVO
import 'package:app_gastro_v1/widgets/resena_card.dart'; // NUEVO
import 'package:app_gastro_v1/widgets/resena_form.dart'; // NUEVO

class DetalleRecetaScreen extends StatefulWidget {
  final Receta receta;

  const DetalleRecetaScreen({super.key, required this.receta});

  @override
  State<DetalleRecetaScreen> createState() => _DetalleRecetaScreenState();
}

class _DetalleRecetaScreenState extends State<DetalleRecetaScreen> {
  final ResenasService _resenasService = ResenasService(); // NUEVO

  // NUEVO: abre el formulario y guarda la reseña que devuelve
  Future<void> _abrirFormularioResena() async {
    final nuevaResena = await showModalBottomSheet<Resena>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ResenaForm(recetaId: widget.receta.id),
    );

    if (nuevaResena == null || !mounted) return;

    setState(() => _resenasService.agregarResena(nuevaResena));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("¡Gracias por tu reseña!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final receta = widget.receta;
    final resenas = _resenasService.obtenerResenas(receta.id); // NUEVO
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle de la receta")),
      // NUEVO: botón flotante para añadir reseña
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormularioResena,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.rate_review_outlined),
        label: const Text("Reseña"),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // 80 abajo para que el botón no tape
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              receta.imagenUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Image.asset(
                "assets/images/plato-placeholder.jpg",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            children: [
              Chip(label: Text('${receta.tiempoTotal} min')),
              Chip(label: Text(receta.dificultad)),
              Chip(label: Text(receta.cocina)),
              Chip(label: Text('${receta.calorias} kcal')),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Ingredientes: ",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...receta.ingredientes.map(
            (ingrediente) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 6, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(child: Text(ingrediente)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Preparación: ",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...receta.instrucciones.asMap().entries.map(
            (entrada) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.deepOrange,
                    child: Text(
                      '${entrada.key + 1}',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(entrada.value)),
                ],
              ),
            ),
          ),
          // NUEVO: sección de reseñas
          const SizedBox(height: 20),
          Text(
            "Reseñas (${resenas.length}): ",
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (resenas.isEmpty)
            Text(
              "Todavía no hay reseñas. ¡Sé el primero!",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ...resenas.map((resena) => ResenaCard(resena: resena)),
        ],
      ),
    );
  }
}
