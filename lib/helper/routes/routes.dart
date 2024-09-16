import 'package:flutter/material.dart';
import 'package:flutter_nelnotes/helper/arguments/detail_arguments.dart';
import 'package:flutter_nelnotes/pages/add_note_page.dart';
import 'package:flutter_nelnotes/pages/detail_page.dart';
import 'package:flutter_nelnotes/pages/edit_note_page.dart';
import 'package:flutter_nelnotes/pages/home_page.dart';
import 'package:flutter_nelnotes/pages/login_page.dart';
import 'package:flutter_nelnotes/pages/profile_page.dart';
import 'package:flutter_nelnotes/pages/search_note_page.dart';
import 'package:flutter_nelnotes/pages/splash_page.dart';

Route onGeneratedRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/login":
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case "/home":
      return MaterialPageRoute(builder: (context) => const HomePage());
    case "/detail":
      return MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as DetailArguments;
          return DetailPage(
            userId: args.userId,
            noteId: args.noteId,
          );
        },
      );
    case "/profile":
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case "/addNote":
      return MaterialPageRoute(builder: (context) => const AddNotePage());
    case "/editNote":
      return MaterialPageRoute(builder: (context) => const EditNotePage());
    case "/searchNote":
      return MaterialPageRoute(builder: (context) => const SearchNotePage());
    default:
      return MaterialPageRoute(builder: (context) => const SplashPage());
  }
}
