import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _hasSeenOnboarding = false;
  String _phoneNumber = '';
  String _userId = '';

  bool get isAuthenticated => _isAuthenticated;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  String get phoneNumber => _phoneNumber;
  String get userId => _userId;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    _phoneNumber = prefs.getString('phoneNumber') ?? '';
    _userId = prefs.getString('userId') ?? '';
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    _hasSeenOnboarding = true;
    notifyListeners();
  }

  Future<bool> sendOTP(String phoneNumber) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    _phoneNumber = phoneNumber;
    return true;
  }

  Future<bool> verifyOTP(String otp) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any 4-digit code
    if (otp.length == 4) {
      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = true;
      _userId = DateTime.now().millisecondsSinceEpoch.toString();
      
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('phoneNumber', _phoneNumber);
      await prefs.setString('userId', _userId);
      
      notifyListeners();
      return true;
    }
    
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _isAuthenticated = false;
    _phoneNumber = '';
    _userId = '';
    notifyListeners();
  }
}