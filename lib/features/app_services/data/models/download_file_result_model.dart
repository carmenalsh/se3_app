import 'dart:typed_data';
import '../../domain/entities/download_file_entity.dart';

class DownloadFileResultModel {
  final Uint8List bytes;
  final String? fileName;
  final String? mimeType;

  const DownloadFileResultModel({
    required this.bytes,
    this.fileName,
    this.mimeType,
  });

  DownloadFileEntity toEntity() => DownloadFileEntity(
        bytes: bytes,
        fileName: fileName,
        mimeType: mimeType,
      );
}
