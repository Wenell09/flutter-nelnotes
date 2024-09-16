import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelnotes/data/base_url/base_url.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserCredential? userCredential;
  User? userDetail;

  Future<String> login() async {
    try {
      await googleSignIn.signOut();
      googleSignInAccount = await googleSignIn.signIn();
      bool isSuccess = await googleSignIn.isSignedIn();
      if (isSuccess) {
        final googleAuth = await googleSignInAccount!.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        userCredential = await firebaseAuth.signInWithCredential(credential);
        userDetail = userCredential!.user;
        final Map<String, dynamic> data = {
          "user_id": userDetail!.uid,
          "username": userDetail!.displayName,
          "email": userDetail!.email,
          "image": userDetail!.photoURL,
        };
        final userId = userDetail!.uid;
        final response = await http.post(
          Uri.parse("$baseUrl/addAccount"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );
        if (response.statusCode == 200) {
          debugPrint("akun dibuat :$userId");
          return userId;
        } else {
          debugPrint("Akun terdaftar :$userId");
          return userId;
        }
      } else {
        throw Exception("gagal login");
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
