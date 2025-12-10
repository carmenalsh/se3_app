class ErrorModel {
  final int status;
  final String errorMessage;

  const ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: _parseStatus(json['errorMessage']),
      errorMessage:
          json['errorMessage']?.toString() ?? 'Unknown error at ErrorModel',
    );
  }

  static int _parseStatus(dynamic value) {
    if (value is int) return value;
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }
}
