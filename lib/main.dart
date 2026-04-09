import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Welcome to Flutter',
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
  var current = WordPair.random();

}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Stack(
              alignment: Alignment.center,
              children: [
                // Fondo 
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 161, 0).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                 
                // Texto
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color.fromARGB(255, 190, 44, 44),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), //Espacio entre elemenytos

            //Elementos laterales
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Estrellas
                const Icon(Icons.star, color: Color.fromARGB(255, 255, 215, 84)),
                const SizedBox(width: 15),
                //Texto
                const Text('Bienvenidos'),
                //Estrella
                const SizedBox(width: 15),
                const Icon(Icons.star, color:  Color.fromARGB(255, 255, 215, 84)),
              ],
            ),
            
            
          ],
        ),
      ),
    );
  }
}