  import '../models/recetas.dart';
  import 'package:flutter/material.dart';
  import '../service/recetas_service.dart';

  class HomeScreen extends StatefulWidget{
    const HomeScreen({super.key});
  @override
  State<HomeScreen> createState()=>_HomeScreenState();
  }
class _HomeScreenState extends State<HomeScreen>{
  late final Future<List<Receta>> _recetasFuture;
  @override
  void initState(){
    super.initState();
    _recetasFuture = RecetaService().obtenerRecetas();
  }


    
  void _mostrarMensajeTemporal(){
    ScaffoldMessenger.of(context)
    .showSnackBar(
      const SnackBar(
        content: Text("El mapa de los pueblos originarios se esta abriendo..."),
      )
    );
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Platillos ancestrales de Quintana Roo"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarMensajeTemporal,
       child: const Icon(Icons.map, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 88, 158, 214),
      ),
    );
  }
}