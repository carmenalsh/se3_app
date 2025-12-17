import 'dart:typed_data';

class DownloadFileEntity {
  final Uint8List bytes;
  final String? fileName;
  final String? mimeType;

  const DownloadFileEntity({
    required this.bytes,
    this.fileName,
    this.mimeType,
  });
}
