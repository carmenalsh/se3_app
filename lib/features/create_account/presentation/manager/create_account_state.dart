import 'package:equatable/equatable.dart';

class CreateAccountState extends Equatable {
  final String description;
  final String? selectedAccount;
  final List<String> accounts;
  const CreateAccountState({
    this.description = '',
    this.selectedAccount,
    this.accounts = const [],
  });
  CreateAccountState copyWith({
    String? description,
    String? selectedAccount,
    List<String>? accounts,
  }) {
    return CreateAccountState(
      description: description ?? this.description,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      accounts: accounts ?? this.accounts,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [description, selectedAccount, accounts];
}
