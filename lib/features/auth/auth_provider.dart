import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user.dart';
import '../../core/providers/app_providers.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? errorMessage;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState());

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Simulated Google Sign In - replace with actual Firebase Auth
      await Future.delayed(const Duration(seconds: 2));

      final user = User(
        id: 1,
        name: 'John Doe',
        email: 'john.doe@gmail.com',
        profilePic: 'default.jpg',
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );

      // Update app state
      ref.read(appStateProvider.notifier).setLoggedIn(true, user: user);

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      // Simulated login
      final user = User(
        id: 1,
        name: 'User',
        email: email,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );

      ref.read(appStateProvider.notifier).setLoggedIn(true, user: user);

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      state = AuthState();
      ref.read(appStateProvider.notifier).setLoggedIn(false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> updateProfile({
    required String fullName,
    required String summary,
    int? gender,
  }) async {
    if (state.user == null) return false;

    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      final updatedUser = state.user!.copyWith(name: fullName);

      state = state.copyWith(
        isLoading: false,
        user: updatedUser,
      );

      ref.read(appStateProvider.notifier).setLoggedIn(true, user: updatedUser);

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
