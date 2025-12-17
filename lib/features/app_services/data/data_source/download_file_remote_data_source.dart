import 'dart:typed_data';

import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/core/errors/expentions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/use_case/params/download_file_params.dart';
import '../models/download_file_result_model.dart';

abstract class DownloadFileRemoteDataSource {
  Future<DownloadFileResultModel> downloadFile({
    required DownloadFileParams params,
  });
}

class DownloadFileRemoteDataSourceImpl implements DownloadFileRemoteDataSource {
  final Dio dio;

  DownloadFileRemoteDataSourceImpl({required this.dio});

  @override
  Future<DownloadFileResultModel> downloadFile({
    required DownloadFileParams params,
  }) async {
    debugPrint(
        "============ DownloadFileRemoteDataSourceImpl.downloadFile ============");

    try {
      final response = await dio.post(
        EndPoints.downloadFile, // ضيفها بالـ EndPoints
        data: params.toMap(),
        options: Options(responseType: ResponseType.bytes),
      );

      final raw = response.data;
      final bytesList = raw is List<int>
          ? raw
          : (raw is Uint8List)
              ? raw.toList()
              : <int>[];

      final bytes = Uint8List.fromList(bytesList);

      final mimeType = response.headers.value('content-type');
      final disposition = response.headers.value('content-disposition');

      String? fileName;
      if (disposition != null) {
        // attachment; filename="report.csv"
        final match = RegExp(r'filename="?([^"]+)"?').firstMatch(disposition);
        fileName = match?.group(1);
      }

      debugPrint("ƒ+? download bytes length: ${bytes.length}");
      debugPrint("ƒ+? mimeType: $mimeType | fileName: $fileName");
      debugPrint("=================================================");

      return DownloadFileResultModel(
        bytes: bytes,
        mimeType: mimeType,
        fileName: fileName,
      );
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }
}
