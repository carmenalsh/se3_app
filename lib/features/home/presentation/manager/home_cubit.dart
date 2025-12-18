import 'package:complaints_app/features/home/domain/entities/transaction_entity.dart';
import 'package:complaints_app/features/home/domain/use_cases/get_transaction_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
     this._getTransActionUseCase,
  ) : super(const HomeState()) {
    debugPrint("============ HomeCubit INIT ============");
    loadTransAction();
  }

   final GetTransActionUseCase _getTransActionUseCase;

  Future<void> loadTransAction({int page = 1, int perPage = 10}) async {
    if (isClosed) return;
    debugPrint("============ HomeCubit.loadTransAction ============");
    debugPrint(
      "loadTransAction -> , current Page: ${state.currentPage} , last page: ${state.lastPage}, per page: ${state.perPage}",
    );
    emit(
      state.copyWith(
        status: HomeStatusEnum.loading,
        transActions: [],
        message: null,
        currentPage: page,
      ),
    );

    final result = await _getTransActionUseCase(
      GetTransActionParams(page: page, perPage: perPage),
    );
if (isClosed) return;
    result.fold(
      (failure) {
        debugPrint("loadTransAction -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: HomeStatusEnum.error,
            message: failure.errMessage,
          ),
        );
      },
      (data) {
        debugPrint("loadTransAction -> SUCCESS: ${data.transAction}");

        emit(
          state.copyWith(
            status: HomeStatusEnum.success,
            transActions: data.transAction,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            perPage: data.meta.perPage,
          ),
        );
      },
    );
  }

  Future<void> loadMoreTransAction() async {
    if (isClosed) return;
    debugPrint(
      "============ HomeCubit.loadMoreTransActionnnnnnnnnnnnnnnnnn ============",
    );

    if (!state.canLoadMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = await _getTransActionUseCase(
      GetTransActionParams(page: nextPage, perPage: state.perPage),
    );
if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, message: failure.errMessage),
      ),
      (data) {
        final newList = [...state.transActions, ...data.transAction];

        emit(
          state.copyWith(
            transActions: newList,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
  Future<void> refreshTransactions() async {
    if (isClosed) return;
  emit(state.copyWith(
    status: HomeStatusEnum.loading,
    transActions: [],
    currentPage: 1,
    lastPage: 1,
    isLoadingMore: false,
    message: null,
  ));

  await loadTransAction(page: 1, perPage: state.perPage);
  if (isClosed) return;
} 
}
