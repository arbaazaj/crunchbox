import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/account.dart';

abstract class RemoteSupabaseAccountDataSource {
  Session? get currentSession;

  Future<Account?> getCurrentUserData();

  Future<AuthResponse> login(String email, String password);

  Future<AuthResponse> register(String name, String email, String password);

  Future<void> logout();
}

class RemoteSupabaseAccountDataSourceImpl
    implements RemoteSupabaseAccountDataSource {
  final SupabaseClient supabaseClient;

  RemoteSupabaseAccountDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<Account?> getCurrentUserData() async {
    try {
      if (currentSession != null) {
        return Account.fromMap(currentSession!.user.toJson());
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user data: $e');
    }
  }

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponse> register(
      String name, String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {'name': name});
      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
