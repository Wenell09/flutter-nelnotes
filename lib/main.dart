import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/search_note/search_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/theme/theme_bloc.dart';
import 'package:flutter_nelnotes/bloc/validasi_note/validasi_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/auth/auth_bloc.dart';
import 'package:flutter_nelnotes/bloc/detail_note/detail_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/bloc/layout/layout_bloc.dart';
import 'package:flutter_nelnotes/bloc/shared_auth/shared_auth_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';
import 'package:flutter_nelnotes/bloc/validasi_search/validasi_search_bloc.dart';
import 'package:flutter_nelnotes/firebase_options.dart';
import 'package:flutter_nelnotes/helper/routes/routes.dart';
import 'package:flutter_nelnotes/repository/auth_repository.dart';
import 'package:flutter_nelnotes/repository/note_repository.dart';
import 'package:flutter_nelnotes/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadTheme()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => SharedAuthBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserRepository()),
        ),
        BlocProvider(
          create: (context) => NoteBloc(NoteRepository()),
        ),
        BlocProvider(
          create: (context) => DetailNoteBloc(NoteRepository()),
        ),
        BlocProvider(
          create: (context) => SearchNoteBloc(NoteRepository()),
        ),
        BlocProvider(
          create: (context) => ValidasiNoteBloc(),
        ),
        BlocProvider(
          create: (context) => ValidasiSearchBloc(),
        ),
        BlocProvider(
          create: (context) => LayoutBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "nelnotes",
            initialRoute: "/",
            theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
            onGenerateRoute: onGeneratedRoute,
          );
        },
      ),
    );
  }
}
