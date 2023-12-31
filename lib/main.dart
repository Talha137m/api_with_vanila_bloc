import 'package:fake_store_api_with_bloc/blocs/post_bloc.dart';
import 'package:fake_store_api_with_bloc/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider(
          create: (context) {
            return PostBloc();
          },
          child: const HomePage()),
    );
  }
}
