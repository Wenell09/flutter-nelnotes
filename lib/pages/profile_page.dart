import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nelnotes/bloc/auth/auth_bloc.dart';
import 'package:flutter_nelnotes/bloc/shared_auth/shared_auth_bloc.dart';
import 'package:flutter_nelnotes/bloc/theme/theme_bloc.dart';
import 'package:flutter_nelnotes/bloc/user/user_bloc.dart';
import 'package:flutter_nelnotes/helper/cut_string/cut_string.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Text(
                            cutString(state.user[0].username),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Text(
                            state.user[0].username,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoaded) {
                          return Text(
                            state.user[0].email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      InkWell(
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          showDialog(
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
                                  "Apakah Anda yakin untuk keluar?",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      "Batal",
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
                                          .read<AuthBloc>()
                                          .add(AuthLogout());
                                      context
                                          .read<SharedAuthBloc>()
                                          .add(SharedAuthSave(userId: ""));
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "/login", (route) => false);
                                    },
                                    child: const Text(
                                      "Logout",
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
                          );
                        },
                        child: const ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.brown,
                            size: 30,
                          ),
                          title: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.brown,
                            size: 30,
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.dark_mode,
                      color: Colors.brown,
                      size: 30,
                    ),
                    title: const Text(
                      "dark Mode",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: BlocBuilder<ThemeBloc, ThemeState>(
                      bloc: context.read<ThemeBloc>()..add(LoadTheme()),
                      builder: (context, state) {
                        return Switch(
                          value: state.isDark,
                          activeColor: Colors.white,
                          activeTrackColor: Colors.grey[700],
                          inactiveTrackColor: Colors.white,
                          inactiveThumbColor: Colors.grey[700],
                          onChanged: (value) async {
                            context
                                .read<ThemeBloc>()
                                .add(SaveTheme(isDark: value));
                          },
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Versi Aplikasi\n1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.28 - 65,
                left: MediaQuery.of(context).size.width / 2 - 62.5,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(state.user[0].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 125,
                      height: 125,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
