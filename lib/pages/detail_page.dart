import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/search_note/search_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/detail_note/detail_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/helper/format_time/format_time.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatelessWidget {
  final String userId, noteId;
  const DetailPage({super.key, required this.userId, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          BlocBuilder<DetailNoteBloc, DetailNoteState>(
            builder: (context, state) {
              if (state is DetailNoteLoaded) {
                final isPin =
                    state.detailNote.any((data) => data.isPin == true);
                if (isPin) {
                  return BlocListener<NoteBloc, NoteState>(
                    listener: (context, state) {
                      if (state is NoteDeletePinSuccess) {
                        context.read<NoteBloc>().add(GetNote(userId: userId));
                        context
                            .read<DetailNoteBloc>()
                            .add(GetDetailNote(userId: userId, noteId: noteId));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("berhasil menghapus pin")));
                      }
                    },
                    child: IconButton(
                        onPressed: () => context
                            .read<NoteBloc>()
                            .add(DeletePin(userId: userId, noteId: noteId)),
                        icon: const Icon(
                          Icons.push_pin,
                          color: Colors.white,
                        )),
                  );
                }
                return BlocListener<NoteBloc, NoteState>(
                  listener: (context, state) {
                    if (state is NoteAddPinSuccess) {
                      context.read<NoteBloc>().add(GetNote(userId: userId));
                      context
                          .read<DetailNoteBloc>()
                          .add(GetDetailNote(userId: userId, noteId: noteId));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Note berhasil di pin")));
                    }
                  },
                  child: IconButton(
                      onPressed: () => context
                          .read<NoteBloc>()
                          .add(AddPin(userId: userId, noteId: noteId)),
                      icon: const Icon(
                        Icons.push_pin_outlined,
                        color: Colors.white,
                      )),
                );
              }
              return IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.push_pin_outlined,
                    color: Colors.white,
                  ));
            },
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed("/editNote"),
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
          ),
          BlocListener<NoteBloc, NoteState>(
            listener: (context, state) {
              if (state is NoteDeleteSuccess) {
                context.read<NoteBloc>().add(GetNote(userId: userId));
                context
                    .read<SearchNoteBloc>()
                    .add(SearchNote(userId: userId, title: ""));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("berhasil menghapus note")));
                Navigator.of(context).pop();
              }
            },
            child: IconButton(
              onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: const Text(
                      textAlign: TextAlign.center,
                      "Hapus note ini?",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Tidak",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<NoteBloc>()
                              .add(DeleteNote(userId: userId, noteId: noteId));
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Ya",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteEditSuccess) {
            context.read<DetailNoteBloc>().add(
                  GetDetailNote(
                    userId: userId,
                    noteId: noteId,
                  ),
                );
          }
        },
        child: BlocBuilder<DetailNoteBloc, DetailNoteState>(
          builder: (context, state) {
            if (state is DetailNoteLoading) {
              return const ShimmerLoading();
            } else if (state is DetailNoteLoaded) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final detailNote = state.detailNote[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detailNote.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          detailNote.deskripsi,
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "dibuat pada: ${formatTimestamp(detailNote.createdAt)}",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    );
                  },
                  itemCount: state.detailNote.length,
                ),
              );
            } else {
              return const ShimmerLoading();
            }
          },
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.04,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.035,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.025,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
