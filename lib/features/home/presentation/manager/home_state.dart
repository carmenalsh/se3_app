part of 'home_cubit.dart';

enum HomeStatusEnum { initial, loading, success, error }

class HomeState {
  final HomeStatusEnum status;
  final List<TransactionEntity> transActions;
  final String? message;

  final int currentPage;
  final int lastPage;
  final int perPage;

  final bool isLoadingMore;

  bool get canLoadMore => currentPage < lastPage;

  const HomeState({
    this.status = HomeStatusEnum.initial,
    this.transActions = const [],
    this.message,
    this.currentPage = 1,
    this.lastPage = 1,
    this.perPage = 10,
    this.isLoadingMore = false,
  });

  HomeState copyWith({
    HomeStatusEnum? status,
    List<TransactionEntity>? transActions,
    String? message,
    bool clearMessage = false,

    int? currentPage,
    int? lastPage,
    int? perPage,

    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      transActions: transActions ?? this.transActions,
      message: clearMessage ? null : (message ?? this.message),
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
