part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.results(
    String phrase,
    List<FoundItem> items,
  ) = _Results;
  const factory SearchState.inProgress() = _InProgress;
  const factory SearchState.notFound() = _NotFound;
}
