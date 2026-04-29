import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../core/api/api_client.dart';
import '../repositories/auth_repository.dart';
import '../models/auth.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ApiClient.instance);
});

// 로그인 상태
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
}

// Auth State
class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final String? error;
  final bool codeSent;
  final int? remainingSeconds;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
    this.codeSent = false,
    this.remainingSeconds,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? error,
    bool? codeSent,
    int? remainingSeconds,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
      codeSent: codeSent ?? this.codeSent,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState()) {
    _checkAutoLogin();
  }

  // 자동 로그인 체크
  Future<void> _checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final autoLogin = prefs.getBool('autoLogin') ?? false;
    final userJson = prefs.getString('user');

    if (autoLogin && userJson != null) {
      try {
        final user = AuthUser.fromJson(json.decode(userJson));
        state = AuthState(
          status: AuthStatus.authenticated,
          user: user,
        );
      } catch (e) {
        state = const AuthState(status: AuthStatus.unauthenticated);
      }
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  // 인증 코드 요청
  Future<bool> requestCode(String phone) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);

    try {
      await _repository.requestCode(phone);
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        codeSent: true,
        remainingSeconds: 180, // 3분
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  // 인증 코드 확인 및 로그인
  Future<bool> verifyCode(String phone, String code, bool autoLogin) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);

    try {
      final response = await _repository.verifyCode(phone, code);

      // 자동 로그인 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('autoLogin', autoLogin);
      await prefs.setString('user', json.encode(response.user.toJson()));

      state = AuthState(
        status: AuthStatus.authenticated,
        user: response.user,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  // 로그아웃
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('autoLogin');
    await prefs.remove('user');

    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  // 코드 재전송을 위한 리셋
  void resetCodeSent() {
    state = state.copyWith(codeSent: false, error: null);
  }

  // 에러 클리어
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
