import 'package:crunchbox/features/account/domain/repositories/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc({required AccountRepository accountRepository})
      : _accountRepository = accountRepository,
        super(AccountInitial()) {
    on<AccountInitialCheck>(_onInitialCheck);
    on<AccountLoginRequested>(_onLogin);
    on<AccountRegisterRequested>(_onRegister);
    on<AccountLogoutRequested>(_onLogout);
  }

  Future<void> _onInitialCheck(
      AccountInitialCheck event, Emitter<AccountState> emit) async {
    try {
      final user = await _accountRepository.getCurrentUser();
      if (user != null) {
        emit(AccountSuccess(account: user));
      } else {
        emit(AccountInitial());
      }
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _onLogin(
      AccountLoginRequested event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      final user =
      await _accountRepository.login(event.email, event.password);
      emit(AccountSuccess(account: user));
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _onRegister(
      AccountRegisterRequested event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      final user = await _accountRepository.register(
          event.name, event.email, event.password);
      emit(AccountSuccess(account: user));
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }

  Future<void> _onLogout(
      AccountLogoutRequested event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      await _accountRepository.logout();
      emit(AccountInitial());
    } catch (e) {
      emit(AccountFailure(message: e.toString()));
    }
  }
}