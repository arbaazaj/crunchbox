import '../../domain/repositories/account_repository.dart';
import '../datasources/remote_supabase_account_data_source.dart';
import '../models/account.dart' as model;
import '../models/account.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteSupabaseAccountDataSource remoteDataSource;

  AccountRepositoryImpl(this.remoteDataSource);

  @override
  Future<Account?> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUserData();
      if (userModel != null) {
        return userModel;
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Account> login(String email, String password) async {
    try {
      final response = await remoteDataSource.login(email, password);
      if (response.user == null) {
        throw Exception('Login failed: User is null');
      }
      return model.Account.fromMap(response.user!.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Account> register(String name, String email, String password) async {
    try {
      final response = await remoteDataSource.register(name, email, password);
      if (response.user == null) {
        throw Exception('Registration failed: User is null');
      }
      return model.Account.fromMap(response.user!.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
