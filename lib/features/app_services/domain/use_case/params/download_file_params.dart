class DownloadFileParams {
  final int accountId;
  final String fileType; 
  final String period;   

  const DownloadFileParams({
    required this.accountId,
    required this.fileType,
    required this.period,
  });

  Map<String, dynamic> toMap() => {
        'account_id': accountId,
        'file_type': fileType,
        'period': period,
      };
}
