class OperationResult {
  final bool ok;
  final String? message;

  const OperationResult._(this.ok, this.message);

  const OperationResult.ok() : this._(true, null);
  const OperationResult.fail(String msg) : this._(false, msg);
}
