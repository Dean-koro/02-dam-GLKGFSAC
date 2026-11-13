import 'package:flutter/material.dart';
import '../models/resena.dart';

class ResenaForm extends StatefulWidget {
  final int recetaId;

  const ResenaForm({super.key, required this.recetaId});

  @override
  State<ResenaForm> createState() => _ResenaFormState();
}

class _ResenaFormState extends State<ResenaForm> {
  final _formKey = GlobalKey<FormState>();
  final _autorController = TextEditingController();
  final _comentarioController = TextEditingController();
  int _calificacion = 0;
  bool _errorEstrellas = false;

  @override
  void dispose() {
    _autorController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  void _guardar() {
    final formularioValido = _formKey.currentState!.validate();
    setState(() => _errorEstrellas = _calificacion == 0);
    if (!formularioValido || _errorEstrellas) return;

    // Cerramos el formulario y devolvemos la reseña a la pantalla de detalle
    Navigator.pop(
      context,
      Resena(
        recetaId: widget.recetaId,
        autor: _autorController.text.trim(),
        calificacion: _calificacion,
        comentario: _comentarioController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Sube el formulario cuando aparece el teclado
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Añadir reseña",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  return IconButton(
                    icon: Icon(
                      i < _calificacion ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () => setState(() {
                      _calificacion = i + 1;
                      _errorEstrellas = false;
                    }),
                  );
                }),
              ),
              if (_errorEstrellas)
                const Text(
                  "Selecciona de 1 a 5 estrellas",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: "Tu nombre",
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => (valor == null || valor.trim().isEmpty)
                    ? "Escribe tu nombre"
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _comentarioController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Comentario",
                  border: OutlineInputBorder(),
                ),
                validator: (valor) => (valor == null || valor.trim().isEmpty)
                    ? "Escribe un comentario"
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.send),
                label: const Text("Publicar reseña"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
