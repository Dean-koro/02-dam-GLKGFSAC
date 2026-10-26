import 'package:flutter/material.dart';
import '../models/recetas.dart';

class RecetasCard extends StatefulWidget {
  final Receta receta;

  const RecetasCard({super.key, required this.receta});

  @override
  State<RecetasCard> createState() => _RecetasCardState();
}

class _RecetasCardState extends State<RecetasCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 130,
              child: Image.network(
                widget.receta.imagenUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.receta.nombre,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 2),
                            Text(
                              '${widget.receta.calificacion}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          widget.receta.cocina,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        const Text(' • ', style: TextStyle(color: Colors.grey)),
                        Text(
                          widget.receta.dificultad,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 112, 180, 217),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.receta.tiempoPreparacionMinutos} min',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.receta.porciones} porc.',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${widget.receta.ingredientes.length} ing. | ${widget.receta.instrucciones.length} pasos',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}