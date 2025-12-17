import 'dart:io';

import 'package:complaints_app/features/app_services/domain/use_case/download_file_use_case.dart';
import 'package:complaints_app/features/app_services/domain/use_case/params/download_file_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'download_file_state.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  final DownloadFileUseCase downloadFileUseCase;

  DownloadFileCubit({required this.downloadFileUseCase})
      : super(const DownloadFileState());

  void fileTypeChanged(String? v) => emit(state.copyWith(selectedFileType: v));
  void periodChanged(String? v) => emit(state.copyWith(selectedPeriod: v));

  Future<void> submitDownload({required int? accountId}) async {
    debugPrint(
        "accountId=$accountId, fileType=${state.selectedFileType}, period=${state.selectedPeriod}");

    debugPrint("============ DownloadFileCubit.submitDownload ============");

    if (state.isSubmitting) return;

    if (accountId == null) {
      emit(state.copyWith(
        message: "يرجى اختيار الحساب",
        clearMessage: false,
      ));
      return;
    }
    final fileType = state.selectedFileType;
    final period = state.selectedPeriod;

    if (fileType == null || fileType.isEmpty) {
      emit(state.copyWith(
        message: "يرجى اختيار نوع الملف (pdf/csv)",
        clearMessage: false,
      ));
      return;
    }
    if (period == null || period.isEmpty) {
      emit(state.copyWith(
        message: "يرجى اختيار الفترة (week/month/year)",
        clearMessage: false,
      ));
      return;
    }

    emit(state.copyWith(
      status: DownloadFileStatus.loading,
      isSubmitting: true,
      downloadSuccess: false,
      savedFilePath: null,
      clearMessage: true,
    ));

    final params = DownloadFileParams(
      accountId: accountId,
      fileType: fileType,
      period: period,
    );

    final result = await downloadFileUseCase.call(params);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
          status: DownloadFileStatus.error,
          isSubmitting: false,
          message: failure.errMessage,
        ));
      },
      (fileEntity) async {
        final dir = await getTemporaryDirectory(); // مجلد مؤقت لكتابة الملف
        final ext = fileType.toLowerCase();
        final path =
            "${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.$ext";
        final f = File(path);
        await f.writeAsBytes(fileEntity.bytes);

        emit(state.copyWith(
          status: DownloadFileStatus.success,
          isSubmitting: false,
          message: "تم تحميل الملف بنجاح",
          downloadSuccess: true,
          savedFilePath: path,
        ));
      },
    );

    debugPrint("=================================================");
  }

  void resetSuccess() {
    if (!state.downloadSuccess) return;
    emit(state.copyWith(downloadSuccess: false));
  }
}
