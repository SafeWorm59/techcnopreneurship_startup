import 'package:flutter/material.dart';

class WalletState {
  static final WalletState _instance = WalletState._internal();
  factory WalletState() => _instance;
  WalletState._internal();

  // Using double to support fractional carbon credits
  final ValueNotifier<double> accumulatedCredits = ValueNotifier<double>(127.50);

  void addCredits(double amount) {
    accumulatedCredits.value += amount;
  }

  void deductCredits(double amount) {
    if (accumulatedCredits.value >= amount) {
      accumulatedCredits.value -= amount;
    }
  }
}

// Global instance to access from anywhere
final globalWallet = WalletState();