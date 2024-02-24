import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_way/repository/api_requests/answer_request.dart';
import 'package:shortest_way/repository/api_responses/success_response.dart';
import 'package:shortest_way/services/bfs.dart';
import 'package:shortest_way/services/navigation_service.dart';
import '../../models/point_model.dart';
import '../../models/answer_model.dart';
import '../../models/started_data_model.dart';
import '../../ui/result_page/result_page.dart';

part 'process_event.dart';

part 'process_state.dart';

class ProcessBloc extends Bloc<ProcessEvent, ProcessState> {
  ProcessBloc() : super(ProcessInitial()) {
    on<StartProcessEvent>(_startProcess);
    on<SendResultToServerEvent>(_sendResultToServer);
  }

  List<StartedDataModel> startedData = [];
  List<List<PointModel>> result = [];
  List<String> ways = [];

  FutureOr<void> _startProcess(
      StartProcessEvent e, Emitter<ProcessState> emit) async {
    // State: the process has started, now the progress value is standard 0
    emit(ProgressValueState());
    startedData = e.startedData;

    for (int i = 0; i < startedData.length; i++) {
      List<PointModel> list111 = BFS().getShortestPath(
        convertToTwoDimensionalArray(startedData[i].field!),
        startedData[i].start!,
        startedData[i].end!,
      );
      result.add(list111);

      // calculate progress value
      double progress = (i + 1) / startedData.length;

      // pause because the processing is fast and the interface does not have time to display the download
      await Future.delayed(const Duration(milliseconds: 300));

      // State: update progress value
      emit(ProgressValueState(progress: progress));
    }
    debugPrint('Result: $result');
  }

  FutureOr<void> _sendResultToServer(
      SendResultToServerEvent e, Emitter<ProcessState> emit) async {
    ways = [];
    List<Map<String, dynamic>> allAnswers = [];

    emit(ProgressValueState(showLoader: true, progress: 1));

    // create List of maps for post request
    for (int i = 0; i < startedData.length; i++) {
      AnswerModel answer = AnswerModel(
        id: startedData[i].id!,
        result: Result(
          steps: result[i],
          path: convertPointsToString(result[i]),
        ),
      );
      allAnswers.add(answer.toJson());
      ways.add(convertPointsToString(result[i]));
    }

    SuccessResponse? response = await AnswerRequest().postAnswer(
      'https://flutter.webspark.dev/flutter/api',
      allAnswers,
    );

    if (response?.success ?? false) {
      emit(SuccessfulSendState());
      NavigationService().push(
        ResultPage(
          startedData: startedData,
          result: result,
          ways: ways,
        ),
      );
    } else {
      emit(FailedSendState(response!.errors ?? "Something went wrong"));
    }
  }
}

/// Convert List<String> to Two dimensional array
List<List<String>> convertToTwoDimensionalArray(List<String> stringList) {
  List<List<String>> twoDimensionalArray = [];

  for (String line in stringList) {
    List<String> row = line.split('');
    twoDimensionalArray.add(row);
  }

  return twoDimensionalArray;
}

/// Converting List of Point to String list for needed type
String convertPointsToString(List<PointModel> points) {
  List<String> pointStrings =
      points.map((point) => "(${point.x},${point.y})").toList();

  // Joining strings with "->"
  String result = pointStrings.join("->");

  return result;
}
