enum OperationType {
  withdraw, // سحب
  deposit, // إيداع
  transfer, // تحويل
}

class OperationConfig {
  final String title;
  final bool showFromAccount;
  final bool showToAccount;
  final bool showAmount;
  final bool operayionAddress;

  const OperationConfig({
    required this.title,
    this.showFromAccount = false,
    this.showToAccount = false,
    this.showAmount = false,
    this.operayionAddress = false,
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
};
