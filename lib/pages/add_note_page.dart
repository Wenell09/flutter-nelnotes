import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/validasi_note/validasi_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputJudul = TextEditingController();
    final inputDeskripsi = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text(
          "Tambah Note",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  } else if (state is NoteAddSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("berhasil menambahkan note")));

                    context.read<NoteBloc>().add(GetNote(userId: state.userId));
                    Navigator.of(context).pop();
                  }
                },
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      return BlocBuilder<ValidasiNoteBloc, ValidasiNoteState>(
                        bloc: context.read<ValidasiNoteBloc>()
                          ..add(
                            ValidasiNote(
                              title: inputJudul.text,
                              deskripsi: inputDeskripsi.text,
                            ),
                          ),
                        builder: (context, state) {
                          if (state is ValidasiNoteInitial) {
                            return InkWell(
                              onTap: () {
                                if (state.isValidate) {
                                  context.read<NoteBloc>().add(AddNote(
                                      userId: userState.user[0].userId,
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
                                  color: (state.isValidate)
                                      ? Colors.brown
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: (state.isSuccess)
                                    ? const Center(
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        "Tambah",
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
}
