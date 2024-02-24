part of 'process_bloc.dart';

@immutable
abstract class ProcessState {}

class ProcessInitial extends ProcessState {}

class StartProcessInitial extends ProcessState {
  final List<StartedDataModel> startedData;

  StartProcessInitial(this.startedData);
}

class ProgressValueState extends ProcessState {
  final double progress;
  final bool showLoader;

  ProgressValueState({
    this.progress = 0,
    this.showLoader = false,
  });
}

class SuccessfulSendState extends ProcessState {
  SuccessfulSendState();
}

class FailedSendState extends ProcessState {
  final String errorMessage;

  FailedSendState(this.errorMessage);
}
