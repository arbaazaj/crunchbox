part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountInitialCheck extends AccountEvent {}

class AccountLoginRequested extends AccountEvent {
  final String email;
  final String password;

  const AccountLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AccountRegisterRequested extends AccountEvent {
  final String name;
  final String email;
  final String password;

  const AccountRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class AccountLogoutRequested extends AccountEvent {}
