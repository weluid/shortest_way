part of 'process_bloc.dart';

@immutable
abstract class ProcessEvent {}

class StartProcessEvent extends ProcessEvent {
  final List<StartedDataModel> startedData;

  StartProcessEvent(this.startedData);
}

class SendResultToServerEvent extends ProcessEvent {
  SendResultToServerEvent();
}
