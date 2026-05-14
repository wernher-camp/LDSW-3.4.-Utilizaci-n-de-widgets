import 'dart:convert'; 
import 'dart:math';    
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; 

// BASE FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); // Coneccion a google
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'BelPelis',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // PokeAPI
  String pokemonName = 'Bel-Pelis';
  String pokemonImageUrl = 'https://definicion.de/wp-content/uploads/2016/09/cine-1.jpg';
  bool isLoading = false;

  //Petición 
  Future<void> fetchPokemon() async {
    isLoading = true;
    notifyListeners();

    final id = Random().nextInt(151) + 1;
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pokemonName = data['name'];
        pokemonImageUrl = data['sprites']['front_default'];
      }
    } catch (e) {
      debugPrint('Error al obtener datos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(appState.pokemonImageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                if (appState.isLoading)
                  const CircularProgressIndicator(),
              ],
            ),

            const SizedBox(height: 30),

            //  estrellas y nombre 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Color.fromARGB(255, 255, 84, 84)),
                const SizedBox(width: 15),
                Text(
                  appState.pokemonName.toUpperCase(),
                  style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.star, color: Color.fromARGB(255, 255, 84, 84)),
              ],
            ),

            const SizedBox(height: 40),

            //  Boton consultar
            ElevatedButton.icon(
              onPressed: () => appState.fetchPokemon(),
              icon: const Icon(Icons.download),
              label: const Text('Consultar Pokemon'),
            ),
            
            const SizedBox(height: 20), 
            // Boton para guardar en la base
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  // Gardamos datos
                  await FirebaseFirestore.instance.collection('pokemons_guardados').add({
                    'nombre': appState.pokemonName,
                    'imagen': appState.pokemonImageUrl,
                    'fecha': DateTime.now(), 
                  });
                  
                  // Mensaje exitoso
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('¡Datos enviados a Firebase!')),
                  );
                } catch (e) {
                  print("Ocurrió un error: $e");
                }
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Guardar en Firebase'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[100],
              ),
            ),
          ],
        ),
      ),
    );
  }
}