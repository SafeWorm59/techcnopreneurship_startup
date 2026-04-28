import 'package:flutter/material.dart';

class AuthState {
  static final AuthState _instance = AuthState._internal();
  factory AuthState() => _instance;
  AuthState._internal();

  final ValueNotifier<String?> currentRole = ValueNotifier<String?>(null);

  bool get isAuthenticated => currentRole.value != null;

  void login(String role) {
    currentRole.value = role;
  }

  void logout() {
    currentRole.value = null;
  }
}

final globalAuth = AuthState();