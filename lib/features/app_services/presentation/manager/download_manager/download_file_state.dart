import 'package:equatable/equatable.dart';

enum DownloadFileStatus { initial, loading, success, error }

class DownloadFileState extends Equatable {
  final DownloadFileStatus status;

  final String? selectedFileType; // pdf | csv
  final String? selectedPeriod;   // week | month | year

  final bool isSubmitting;
  final String? message;

  /// نستخدمها لإغلاق البوتم شيت مرة واحدة
  final bool downloadSuccess;

  /// مسار الملف بعد الحفظ (حتى نفتح الملف)
  final String? savedFilePath;

  const DownloadFileState({
    this.status = DownloadFileStatus.initial,
    this.selectedFileType = 'pdf',
    this.selectedPeriod = 'month',
    this.isSubmitting = false,
    this.message,
    this.downloadSuccess = false,
    this.savedFilePath,
  });

  DownloadFileState copyWith({
    DownloadFileStatus? status,
    String? selectedFileType,
    String? selectedPeriod,
    bool? isSubmitting,
    String? message,
    bool clearMessage = false,
    bool? downloadSuccess,
    String? savedFilePath,
  }) {
    return DownloadFileState(
      status: status ?? this.status,
      selectedFileType: selectedFileType ?? this.selectedFileType,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      message: clearMessage ? null : (message ?? this.message),
      downloadSuccess: downloadSuccess ?? this.downloadSuccess,
      savedFilePath: savedFilePath ?? this.savedFilePath,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedFileType,
        selectedPeriod,
        isSubmitting,
        message,
        downloadSuccess,
        savedFilePath,
      ];
}
