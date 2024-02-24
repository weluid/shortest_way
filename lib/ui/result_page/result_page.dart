import 'package:flutter/material.dart';
import 'package:shortest_way/services/navigation_service.dart';
import 'package:shortest_way/ui/result_page/grip_view_screen.dart';
import '../../models/point_model.dart';
import '../../models/started_data_model.dart';

class ResultPage extends StatefulWidget {
  final List<StartedDataModel> startedData;
  final List<List<PointModel>> result;
  final List<String> ways;

  const ResultPage({
    super.key,
    required this.startedData,
    required this.result,
    required this.ways,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        itemCount: widget.ways.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () {
              NavigationService().push(
                GridViewScreen(
                  grid: widget.startedData[index].field!,
                  path: widget.ways[index],
                  result: widget.result[index],
                ),
              );
            },
            child: Text(
              widget.ways[index],
            ),
          );
        },
      ),
    );
  }
}
