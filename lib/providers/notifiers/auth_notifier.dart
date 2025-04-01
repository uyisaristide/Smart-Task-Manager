import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserNotifier extends StateNotifier<UserState?> {
  UserNotifier() : super(UserState.initial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      state = state!.copyWith(isLoading: true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        state = UserState(user: firebaseUser, isLoading: false);
        await saveUserToPreferences(firebaseUser);
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign-in failed')),
      );
    } finally {
      state = state!.copyWith(isLoading: false);
    }
  }

  Future<void> signUp(BuildContext context, String email, String password) async {
    try {
      state = state!.copyWith(isLoading: true);
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        state = UserState(user: firebaseUser, isLoading: false);
        await saveUserToPreferences(firebaseUser);
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Sign-up failed')),
      );
    } finally {
      state = state!.copyWith(isLoading: false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    state = UserState(user: null, isLoading: false);
    context.go('/login');
  }

  Future<void> saveUserToPreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode({
      'uid': user.uid,
      'email': user.email,
    });
    await prefs.setString('user', userJson);
  }
}

class UserState {
  final User? user;
  final bool isLoading;

  UserState({this.user, required this.isLoading});

  factory UserState.initial() => UserState(user: null, isLoading: false);

  UserState copyWith({User? user, bool? isLoading}) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
