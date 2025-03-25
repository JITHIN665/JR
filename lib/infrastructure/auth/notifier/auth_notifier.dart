import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jr/infrastructure/auth/provider/provider.dart';
import '../repository/auth_repository.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, User?>(() => AuthNotifier());

class AuthNotifier extends AsyncNotifier<User?> {
  late final AuthRepository _authRepository;

  @override
  FutureOr<User?> build() {
    _authRepository = AuthRepository(ref.read(firebaseAuthProvider));
    return null; // initial state
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _authRepository.login(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();
    try {
      final user = await _authRepository.signUp(email, password);
      state = AsyncData(user);
    } catch (e, st) {
      print("hiiiiiiiii");
      state = AsyncError(e, st);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authRepository.sendResetEmail(email);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
