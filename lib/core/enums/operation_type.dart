enum OperationType {
  withdraw, // سحب
  deposit, // إيداع
  transfer, // تحويل
  editAccount,
}

class OperationConfig {
  final String title;
  final bool showFromAccount;
  final bool showToAccount;
  final bool showAmount;
  final bool operayionAddress;
  final bool showAccountName;
  final bool showAccountState;
  final bool showAccountDescription;

  const OperationConfig({
    required this.title,
    this.showFromAccount = false,
    this.showToAccount = false,
    this.showAmount = false,
    this.operayionAddress = false,
    this.showAccountDescription = false,
    this.showAccountName = false,
    this.showAccountState = false,
  });
}

const operationConfigs = {
  OperationType.withdraw: OperationConfig(
    title: 'سحب',
    showFromAccount: true,
    showAmount: true,
    operayionAddress: true,
  ),
  OperationType.deposit: OperationConfig(
    title: 'إيداع',
    showFromAccount: true,
    showAmount: true,
    operayionAddress: true,
  ),
  OperationType.transfer: OperationConfig(
    title: 'تحويل',
    showFromAccount: true,
    showToAccount: true,
    operayionAddress: true,
    showAmount: true,
  ),
  OperationType.editAccount:OperationConfig(
    title: 'تعديل الحساب',
    showAccountName: true,
    showAccountState: true,
    showAccountDescription: true,
    )
};
