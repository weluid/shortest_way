import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_way/services/navigation_service.dart';
import '../../repository/api_requests/started_data_request.dart';
import '../../repository/api_responses/started_response.dart';
import '../../ui/process_page/process_page.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageInitial()) {
    on<GetDataFromServerEvent>(_startCountingProcess);
  }

  FutureOr<void> _startCountingProcess(
    GetDataFromServerEvent e,
    Emitter<MainPageState> emit,
  ) async {
    emit(LoadingState());
    try {
      StartedDataResponse? startedData =
          await StartedRequest().getStartedData(e.url.trim());
      if (startedData?.success ?? false) {
        emit(SuccessfulLoadingLoadingState());
        NavigationService().push(
          ProcessPage(startedData: startedData!.startedData!),
        );
      } else {
        emit(
          FailedLoadingLoadingState(
              startedData!.errors ?? "Something went wrong"),
        );
      }
    } catch (e) {
      print('1223');
      emit(
        FailedLoadingLoadingState("Something went wrong"),
      );
    }
  }
}
