import 'package:complaints_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/download_file_entity.dart';
import '../use_case/params/download_file_params.dart';

abstract class DownloadFileRepository {
  Future<Either<Failure, DownloadFileEntity>> downloadFile({
    required DownloadFileParams params,
  });
}
