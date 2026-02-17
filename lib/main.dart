import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyro_notes_application/core/database/app_database.dart';
import 'package:tyro_notes_application/cubit/sort_cubit.dart';
import 'package:tyro_notes_application/cubit/theme_cubit.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_event.dart';

import 'features/notes/bloc/note_bloc.dart';
import 'features/notes/screens/note_list_screens.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder('note_database.db')
      .build();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {

  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SortCubit()),
          BlocProvider(create: (context)=> NoteBloc(noteDao: database.noteDao, sortCubit: context.read<SortCubit>())..add(LoadNotes())),
          BlocProvider(create: (context)=> ThemeCubit()),
        ],
        child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDark){
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  useMaterial3: true,
                  brightness: Brightness.light,
                ),
                darkTheme: ThemeData(
                    primarySwatch: Colors.blue,
                    useMaterial3: true,
                    brightness: Brightness.dark
                ),
                themeMode: isDark? ThemeMode.dark : ThemeMode.light,
                home: NotesListScreen(),
              );
            }
        )
    );
  }
}
