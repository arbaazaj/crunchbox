part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final Account account;

  const AccountSuccess({required this.account});

  @override
  List<Object> get props => [account];
}

class AccountFailure extends AccountState {
  final String message;

  const AccountFailure({required this.message});

  @override
  List<Object> get props => [message];
}