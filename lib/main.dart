import 'package:anecnote/screens/my_home_page.dart';
import 'package:anecnote/screens/my_settings_page.dart';
import 'package:anecnote/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/note_database.dart';

void main() async {

  //initialise database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();


  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => NoteDatabase(),
      ),
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ],
      child: const MyApp(),
    ),


  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AnecNote',
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const MyHomePage(),
      routes: {
        '/settings':(context) => const MySettings()
      },
    );
  }
}

