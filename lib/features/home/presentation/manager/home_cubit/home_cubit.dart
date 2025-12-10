import 'package:complaints_app/features/home/domain/entities/notification_entity.dart';
import 'package:complaints_app/features/home/domain/use_cases/get_complaints_use_case.dart';
import 'package:complaints_app/features/home/domain/use_cases/get_notifications_use_case.dart';
import 'package:complaints_app/features/home/domain/use_cases/search_complaint_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/complaint_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getComplaintsUseCase,
    this._searchComplaintUseCase,
    this._getNotificationsUseCase,
  ) : super(const HomeState()) {
    debugPrint("============ HomeCubit INIT ============");
    loadComplaints();
  }

  final GetComplaintsUseCase _getComplaintsUseCase;
  final SearchComplaintUseCase _searchComplaintUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;

  Future<void> loadComplaints({int page = 1, int perPage = 10}) async {
    debugPrint("============ HomeCubit.loadComplaints ============");
    debugPrint(
      "loadComplaints -> , current Page: ${state.currentPage} , last page: ${state.lastPage}, per page: ${state.perPage}",
    );
    emit(
      state.copyWith(
        status: HomeStatusEnum.loading,
        complaints: [],
        isSearchMode: false,
        message: null,
        currentPage: page,
      ),
    );

    final result = await _getComplaintsUseCase(
      GetComplaintsParams(page: page, perPage: perPage),
    );

    result.fold(
      (failure) {
        debugPrint("loadComplaints -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            status: HomeStatusEnum.error,
            message: failure.errMessage,
          ),
        );
      },
      (data) {
        debugPrint("loadComplaints -> SUCCESS: ${data.complaints}");

        emit(
          state.copyWith(
            status: HomeStatusEnum.success,
            complaints: data.complaints,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            perPage: data.meta.perPage,
          ),
        );
      },
    );
  }

  Future<void> loadMoreComplaints() async {
    debugPrint(
      "============ HomeCubit.loadMoreComplaintssssssssssssss ============",
    );

    if (!state.canLoadMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = await _getComplaintsUseCase(
      GetComplaintsParams(page: nextPage, perPage: state.perPage),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, message: failure.errMessage),
      ),
      (data) {
        final newList = [...state.complaints, ...data.complaints];

        emit(
          state.copyWith(
            complaints: newList,
            currentPage: data.meta.currentPage,
            lastPage: data.meta.lastPage,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  void searchTextChanged(String value) {
    debugPrint("HomeCubit.searchTextChanged -> $value");
    emit(state.copyWith(searchText: value));
  }

  Future<void> cancelSearch() async {
    debugPrint("HomeCubit.cancelSearch");
    emit(state.copyWith(searchText: '', isSearchMode: false));
    await loadComplaints(page: 1, perPage: state.perPage);
  }

  Future<void> searchComplaint(String search) async {
    final trimmed = search.trim();

    if (trimmed.isEmpty) {
      await loadComplaints(page: 1, perPage: state.perPage);
      return;
    }

    emit(
      state.copyWith(
        status: HomeStatusEnum.loading,
        complaints: [],
        isSearchMode: true,
        message: null,
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final result = await _searchComplaintUseCase(trimmed);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeStatusEnum.error,
            message: failure.errMessage,
          ),
        );
      },
      (complaint) {
        if (complaint == null) {
          emit(
            state.copyWith(
              status: HomeStatusEnum.success,
              complaints: const [],
              isSearchMode: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: HomeStatusEnum.success,
              complaints: [complaint],
              isSearchMode: true,
            ),
          );
        }
      },
    );
  }

  Future<void> loadNotifications() async {
    debugPrint("============ HomeCubit.loadNotifications ============");

    emit(
      state.copyWith(
        isNotificationsLoading: true,
        notificationsErrorMessage: null,
      ),
    );

    final result = await _getNotificationsUseCase();

    result.fold(
      (failure) {
        debugPrint("loadNotifications -> FAILURE: ${failure.errMessage}");
        emit(
          state.copyWith(
            isNotificationsLoading: false,
            notificationsErrorMessage: failure.errMessage,
          ),
        );
      },
      (list) {
        debugPrint("loadNotifications -> SUCCESS, count: ${list.length}");
        emit(
          state.copyWith(isNotificationsLoading: false, notifications: list),
        );
      },
    );
  }
}
