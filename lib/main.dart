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
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                                  image: DecorationImage(
                                  image: NetworkImage('https://definicion.de/wp-content/uploads/2016/09/cine-1.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ),
                                          
                // Texto fondoo
                Text(
                  'Bel-Pelis',
                  style: TextStyle(
                    fontSize: 52,
                    color: Color.fromARGB(255, 204, 255, 2),
                  ),
                ),
              ],
            ),

            //Espacio entre elemenytos
            const SizedBox(height: 30),

            //Elementos laterales
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Estrellas
                const Icon(Icons.star, color: Color.fromARGB(255, 255, 215, 84)),
                const SizedBox(width: 15),
                //Texto
                const Text('Hello World',
                 style: TextStyle(fontSize: 32.0,)
                 ),
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