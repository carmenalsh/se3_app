import 'package:complaints_app/core/errors/expentions.dart';
import 'package:complaints_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/download_file_entity.dart';
import '../../domain/repository/download_file_repository.dart';
import '../../domain/use_case/params/download_file_params.dart';
import '../data_source/download_file_remote_data_source.dart';

class DownloadFileRepositoryImpl implements DownloadFileRepository {
  final DownloadFileRemoteDataSource remoteDataSource;

  DownloadFileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DownloadFileEntity>> downloadFile({
    required DownloadFileParams params,
  }) async {
    try {
      final model = await remoteDataSource.downloadFile(params: params);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (_) {
      return Left(ServerFailure(errMessage: 'حدث خطأ غير متوقع'));
    }
  }
}
