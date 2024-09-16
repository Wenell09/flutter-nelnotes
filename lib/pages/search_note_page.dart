import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/bloc/search_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/detail_note/detail_note_bloc.dart';
import 'package:flutter_nelnotes/bloc/layout/layout_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';
import 'package:flutter_nelnotes/bloc/validasi_search/validasi_search_bloc.dart';
import 'package:flutter_nelnotes/helper/arguments/detail_arguments.dart';
import 'package:shimmer/shimmer.dart';

class SearchNotePage extends StatelessWidget {
  const SearchNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputSearch = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          leading: Container(),
          backgroundColor: Colors.brown,
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoaded) {
                            return TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: inputSearch,
                              onChanged: (value) {
                                context
                                    .read<ValidasiSearchBloc>()
                                    .add(ShowButtonClear(title: value));
                                context.read<SearchNoteBloc>().add(SearchNote(
                                    userId: state.user[0].userId,
                                    title: inputSearch.text));
                              },
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                suffixIcon: BlocBuilder<ValidasiSearchBloc,
                                    ValidasiSearchState>(
                                  builder: (context, validasiState) {
                                    if (validasiState.isShowButtonClear) {
                                      return IconButton(
                                        onPressed: () {
                                          context
                                              .read<ValidasiSearchBloc>()
                                              .add(ClearInput());
                                          inputSearch.clear();
                                          context.read<SearchNoteBloc>().add(
                                              SearchNote(
                                                  userId: state.user[0].userId,
                                                  title: inputSearch.text));
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 25,
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                border: InputBorder.none,
                                hintText: "Cari note yuk!",
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<LayoutBloc, LayoutState>(
            bloc: context.read<LayoutBloc>()..add(LayoutLoad()),
            builder: (context, layoutState) {
              return BlocBuilder<SearchNoteBloc, SearchNoteState>(
                builder: (context, state) {
                  if (state is SearchNoteLoading) {
                    if (layoutState.isGrid) {
                      return const ShimmerLoading();
                    } else {
                      return const ShimmerLoadingRow();
                    }
                  } else if (state is SearchNoteLoaded) {
                    if (layoutState.isGrid) {
                      if (state.note.isEmpty) {
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
                          final note = state.note[index];
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        itemCount: state.note.length,
                      );
                    } else {
                      if (state.note.isEmpty) {
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
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final note = state.note[index];
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
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
                          itemCount: state.note.length,
                        ),
                      );
                    }
                  } else if (state is SearchNoteError) {
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
