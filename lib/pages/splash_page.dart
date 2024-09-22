import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/bloc/shared_auth/shared_auth_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedAuthBloc, SharedAuthState>(
      bloc: context.read<SharedAuthBloc>()..add(SharedAuthLoad()),
      listener: (context, state) {
        if (state is SharedAuthLoaded) {
          context.read<UserBloc>().add(GetUser(userId: state.userId));
          context.read<NoteBloc>().add(GetNote(userId: state.userId));
          Future.delayed(const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacementNamed("/home"));
        } else {
          Future.delayed(const Duration(seconds: 2),
              () => Navigator.of(context).pushReplacementNamed("/login"));
        }
      },
      builder: (context, state) {
        return const Scaffold(
          backgroundColor: Colors.brown,
          body: Center(
            child: Text(
              "Welcome to Nelnotes",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}
