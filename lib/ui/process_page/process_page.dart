import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_way/bloc/process_page_bloc/process_bloc.dart';
import 'package:shortest_way/ui/process_page/process_page_view.dart';

import '../../models/started_data_model.dart';
import '../loading_screen.dart';

class ProcessPage extends StatefulWidget {
  final List<StartedDataModel> startedData;

  const ProcessPage({super.key, required this.startedData});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  void initState() {
    super.initState();

    context.read<ProcessBloc>().add(StartProcessEvent(widget.startedData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcessBloc, ProcessState>(
      builder: (BuildContext context, state) {
        if (state is StartProcessInitial) {
          return const ProcessPageView();
        } else if (state is ProgressValueState) {
          return ProcessPageView(
            process: state.progress,
            showLoader: state.showLoader,
          );
        } else if (state is SuccessfulSendState) {
          return const ProcessPageView(process: 1);
        } else if (state is FailedSendState) {
          return  ProcessPageView(
            process: 1,
            errorMessage: state.errorMessage,
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
