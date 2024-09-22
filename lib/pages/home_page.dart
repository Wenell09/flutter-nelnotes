import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/search_note/search_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/detail_note/detail_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/note/note_bloc.dart';
import 'package:flutter_nelnotes/bloc/layout/layout_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';
import 'package:flutter_nelnotes/helper/arguments/detail_arguments.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoaded) {
                return UnconstrainedBox(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.of(context).pushNamed("/searchNote");
                      context.read<SearchNoteBloc>().add(
                          SearchNote(userId: state.user[0].userId, title: ""));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          const Text(
                            "Telusuri catatan Anda",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.17,
                          ),
                          IconButton(
                            onPressed: () =>
                                context.read<LayoutBloc>().add(LayoutSave()),
                            icon: BlocBuilder<LayoutBloc, LayoutState>(
                              bloc: context.read<LayoutBloc>()
                                ..add(LayoutLoad()),
                              builder: (context, state) {
                                if (state.isGrid) {
                                  return const Icon(
                                    Icons.table_rows_outlined,
                                    color: Colors.white,
                                  );
                                } else {
                                  return const Icon(
                                    Icons.window_outlined,
                                    color: Colors.white,
                                  );
                                }
                              },
                            ),
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoading) {
                                return const ShimmerLoadingCircle();
                              } else if (state is UserLoaded) {
                                return InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed("/profile"),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(state.user[0].image),
                                    backgroundColor: Colors.white,
                                  ),
                                );
                              }
                              return const ShimmerLoadingCircle();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: UnconstrainedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          BlocBuilder<LayoutBloc, LayoutState>(
            bloc: context.read<LayoutBloc>()..add(LayoutLoad()),
            builder: (context, layoutState) {
              return BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteLoading) {
                    if (layoutState.isGrid) {
                      return const ShimmerLoading();
                    } else {
                      return const ShimmerLoadingRow();
                    }
                  } else if (state is NoteLoaded) {
                    if (layoutState.isGrid) {
                      if (state.notes.isEmpty) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: const Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Note kosong,mari buat note yuk!",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        );
                      } else {
                        final isPin = state.notes.any(
                          (element) => element.isPin == true,
                        );
                        if (isPin) {
                          final filteredPinNote = state.notes
                              .where(
                                (element) => element.isPin == true,
                              )
                              .toList();
                          final filteredNote = state.notes
                              .where(
                                (element) => element.isPin == false,
                              )
                              .toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20, left: 30),
                                child: Text("Dipasangi pin"),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 2 / 2.3,
                                ),
                                padding: const EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  final note = filteredPinNote[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      context.read<DetailNoteBloc>().add(
                                            GetDetailNote(
                                              userId: note.userId,
                                              noteId: note.noteId,
                                            ),
                                          );
                                      Navigator.of(context).pushNamed(
                                        "/detail",
                                        arguments: DetailArguments(
                                          userId: note.userId,
                                          noteId: note.noteId,
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Flexible(
                                                child: Text(note.deskripsi))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: filteredPinNote.length,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, left: 30),
                                child: Text("Lainnya"),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 2 / 2.3,
                                ),
                                padding: const EdgeInsets.all(10),
                                itemBuilder: (context, index) {
                                  final note = filteredNote[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      context.read<DetailNoteBloc>().add(
                                            GetDetailNote(
                                              userId: note.userId,
                                              noteId: note.noteId,
                                            ),
                                          );
                                      Navigator.of(context).pushNamed(
                                        "/detail",
                                        arguments: DetailArguments(
                                          userId: note.userId,
                                          noteId: note.noteId,
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              note.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Flexible(
                                                child: Text(note.deskripsi))
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: filteredNote.length,
                              ),
                            ],
                          );
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2 / 2.3,
                          ),
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.read<DetailNoteBloc>().add(
                                      GetDetailNote(
                                        userId: note.userId,
                                        noteId: note.noteId,
                                      ),
                                    );
                                Navigator.of(context).pushNamed(
                                  "/detail",
                                  arguments: DetailArguments(
                                    userId: note.userId,
                                    noteId: note.noteId,
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        note.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Flexible(child: Text(note.deskripsi))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: state.notes.length,
                        );
                      }
                    } else {
                      if (state.notes.isEmpty) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: const Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Note kosong,mari buat note yuk!",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        );
                      } else {
                        final isPin = state.notes.any(
                          (element) => element.isPin == true,
                        );
                        if (isPin) {
                          final filteredPinNote = state.notes
                              .where(
                                (element) => element.isPin == true,
                              )
                              .toList();
                          final filteredNote = state.notes
                              .where(
                                (element) => element.isPin == false,
                              )
                              .toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20, left: 30),
                                child: Text("Dipasangi pin"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final note = filteredPinNote[index];
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        context.read<DetailNoteBloc>().add(
                                              GetDetailNote(
                                                userId: note.userId,
                                                noteId: note.noteId,
                                              ),
                                            );
                                        Navigator.of(context).pushNamed(
                                          "/detail",
                                          arguments: DetailArguments(
                                            userId: note.userId,
                                            noteId: note.noteId,
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                note.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Flexible(
                                                  child: Text(note.deskripsi))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: filteredPinNote.length,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 15, left: 30),
                                child: Text("Lainnya"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final note = filteredNote[index];
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        context.read<DetailNoteBloc>().add(
                                              GetDetailNote(
                                                userId: note.userId,
                                                noteId: note.noteId,
                                              ),
                                            );
                                        Navigator.of(context).pushNamed(
                                          "/detail",
                                          arguments: DetailArguments(
                                            userId: note.userId,
                                            noteId: note.noteId,
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                note.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Flexible(
                                                  child: Text(note.deskripsi))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: filteredNote.length,
                                ),
                              ),
                            ],
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final note = state.notes[index];
                              return InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  context.read<DetailNoteBloc>().add(
                                        GetDetailNote(
                                          userId: note.userId,
                                          noteId: note.noteId,
                                        ),
                                      );
                                  Navigator.of(context).pushNamed(
                                    "/detail",
                                    arguments: DetailArguments(
                                      userId: note.userId,
                                      noteId: note.noteId,
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Flexible(child: Text(note.deskripsi))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.notes.length,
                          ),
                        );
                      }
                    }
                  } else if (state is NoteError) {
                    if (layoutState.isGrid) {
                      return const ShimmerLoading();
                    } else {
                      return const ShimmerLoadingRow();
                    }
                  }
                  return Container();
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/addNote"),
        backgroundColor: Colors.brown,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ShimmerLoadingRow extends StatelessWidget {
  const ShimmerLoadingRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            5,
            (index) => Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerLoadingCircle extends StatelessWidget {
  const ShimmerLoadingCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const CircleAvatar(),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 2.3,
        ),
        padding: const EdgeInsets.all(8.0),
        children: List.generate(6, (index) => const Card()),
      ),
    );
  }
}
