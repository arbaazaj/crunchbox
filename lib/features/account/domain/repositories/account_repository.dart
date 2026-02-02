import '../../data/models/account.dart';

abstract class AccountRepository {
  Future<Account?> getCurrentUser();

  Future<Account> login(String email, String password);

  Future<Account> register(String name, String email, String password);

  Future<void> logout();
}
