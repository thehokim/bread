import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ProfileRepository {
  const ProfileRepository();

  Future<void> removeProfile();
}

final class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> removeProfile() async {}
}
