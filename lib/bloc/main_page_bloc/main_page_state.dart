part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {}

class MainPageInitial extends MainPageState {}

class StartCountingProcessState extends MainPageState {}

class LoadingState extends MainPageState {}

class SuccessfulLoadingLoadingState extends MainPageState {
  SuccessfulLoadingLoadingState();
}

class FailedLoadingLoadingState extends MainPageState {
  final String errorMessage;
  FailedLoadingLoadingState(this.errorMessage);
}
