import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_page_bloc/main_page_bloc.dart';
import '../../global_widgets/common_button.dart';

class MainPageView extends StatelessWidget {
  final String? errorMessage;

  const MainPageView({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              errorMessage != null ? Text(errorMessage!) : const SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.compare_arrows),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: "Input your url",
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CommonButton(
                onTap: () {
                  if (textController.text.isEmpty) {
                    return;
                  } else {
                    BlocProvider.of<MainPageBloc>(context)
                        .add(GetDataFromServerEvent(textController.text));
                  }
                },
                text: 'Start counting process',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
