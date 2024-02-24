import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortest_way/global_widgets/common_button.dart';

import '../../bloc/process_page_bloc/process_bloc.dart';

class ProcessPageView extends StatefulWidget {
  final double process;
  final bool showLoader;
  final String? errorMessage;

  const ProcessPageView({
    Key? key,
    this.process = 0,
    this.showLoader = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  State<ProcessPageView> createState() => _ProcessPageViewState();
}

class _ProcessPageViewState extends State<ProcessPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Process screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.errorMessage != null
                  ? Text(widget.errorMessage!)
                  : const SizedBox(),
              Text(
                widget.process != 1 && widget.showLoader == false
                    ? "Calculation..."
                    : "Calculations finished",
              ),
              const SizedBox(height: 30),
              Text(
                "${(widget.process * 100).toInt()}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              widget.showLoader
                  ? const CircularProgressIndicator.adaptive()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CommonButton(
          onTap: widget.showLoader || widget.process != 1
              ? null
              : () {
                  context.read<ProcessBloc>().add(
                        SendResultToServerEvent(),
                      );
                },
          text: "Send result to server",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
