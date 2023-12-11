import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_drawer_animation/provider/page_provider.dart';
import 'zoom_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      child: MaterialApp(
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
          debugShowCheckedModeBanner: false,
          home: const ZoomDrawerAnimation(),
        ),
    );
  }
}
