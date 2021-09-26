import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task1app/Provider/connectivity.dart';
import 'package:task1app/bloc/Music/music_bloc.dart';
import 'package:task1app/data/repository/music_repository.dart';
import 'package:task1app/ui/HomePage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ConnectivityProvider(),
              child: const HomePage()),
        ],
        child: MaterialApp(
          title: 'MusicApp',
          debugShowCheckedModeBanner: false,
          home: BlocProvider(
            create: (context) => MusicBloc(repository: MusicRepositoryImpl()),
            child: const HomePage(),
          ),
        ));
  }
}
