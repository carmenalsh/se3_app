import 'package:complaints_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/download_file_entity.dart';
import '../repository/download_file_repository.dart';
import 'params/download_file_params.dart';

class DownloadFileUseCase {
  final DownloadFileRepository repository;

  const DownloadFileUseCase({required this.repository});

  Future<Either<Failure, DownloadFileEntity>> call(DownloadFileParams params) {
    return repository.downloadFile(params: params);
  }
}
