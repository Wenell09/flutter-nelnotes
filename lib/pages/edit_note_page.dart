import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/search_note/search_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/detail_note/detail_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';
import 'package:flutter_nelnotes/bloc/validasi_note/validasi_note_bloc.dart';

class EditNotePage extends StatelessWidget {
  const EditNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailNoteBloc, DetailNoteState>(
      builder: (context, state) {
        if (state is DetailNoteLoaded) {
          final inputJudul =
              TextEditingController(text: state.detailNote[0].title);
          final inputDeskripsi =
              TextEditingController(text: state.detailNote[0].deskripsi);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              title: const Text(
                "Edit Note",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: inputJudul,
                    onChanged: (value) {
                      context.read<ValidasiNoteBloc>().add(
                            ValidasiNote(
                              title: inputJudul.text,
                              deskripsi: inputDeskripsi.text,
                            ),
                          );
                    },
                    decoration: const InputDecoration(
                      hintText: "Masukkan judul",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    maxLines: null,
                    controller: inputDeskripsi,
                    onChanged: (value) {
                      context.read<ValidasiNoteBloc>().add(
                            ValidasiNote(
                              title: inputJudul.text,
                              deskripsi: inputDeskripsi.text,
                            ),
                          );
                    },
                    decoration: const InputDecoration(
                      hintText: "Masukkan deskripsi",
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocListener<NoteBloc, NoteState>(
                      listener: (context, state) {
                        if (state is NoteError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        } else if (state is NoteEditSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("berhasil mengubah note")));
                          context
                              .read<NoteBloc>()
                              .add(GetNote(userId: state.userId));
                          context
                              .read<SearchNoteBloc>()
                              .add(SearchNote(userId: state.userId, title: ""));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, userState) {
                          if (userState is UserLoaded) {
                            return BlocBuilder<ValidasiNoteBloc,
                                ValidasiNoteState>(
                              bloc: context.read<ValidasiNoteBloc>()
                                ..add(
                                  ValidasiNote(
                                    title: inputJudul.text,
                                    deskripsi: inputDeskripsi.text,
                                  ),
                                ),
                              builder: (context, validasiState) {
                                if (validasiState is ValidasiNoteInitial) {
                                  return InkWell(
                                    onTap: () {
                                      if (validasiState.isValidate) {
                                        context.read<NoteBloc>().add(EditNote(
                                            userId: userState.user[0].userId,
                                            noteId: state.detailNote[0].noteId,
                                            title: inputJudul.text,
                                            deskripsi: inputDeskripsi.text));
                                        context
                                            .read<ValidasiNoteBloc>()
                                            .add(ValidasiNoteEnd());
                                        FocusScope.of(context).unfocus();
                                      } else {
                                        null;
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: (validasiState.isValidate)
                                            ? Colors.brown
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: (validasiState.isSuccess)
                                          ? const Center(
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              "Edit Note",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            );
                          }
                          return Container();
                        },
                      ),
                    )),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
