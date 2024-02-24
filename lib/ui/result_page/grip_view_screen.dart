import 'package:flutter/material.dart';
import 'package:shortest_way/models/point_model.dart';
import 'package:shortest_way/utils/constants.dart';

class GridViewScreen extends StatelessWidget {
  final List<String> grid;
  final String path;
  final List<PointModel> result;

  const GridViewScreen({
    super.key,
    required this.grid,
    required this.path,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    List<String> gridData = grid;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Preview screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridData[0].length,
          ),
          itemBuilder: (context, index) {
            int row = index ~/ gridData[0].length;
            int col = index % gridData[0].length;
            String value = gridData[row][col];

            Color cellColor = _setColorValue(row, col, value);

            return GridTile(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: cellColor,
                ),
                child: Center(
                  child: Text(
                    '${col.toString()}.${row.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: value == AppConstants.blockedPositionValue
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: gridData.length * gridData[0].length,
        ),
      ),
    );
  }

  Color _setColorValue(int row, int col, String value) {
    // Check if the current cell is in the result path
    if (col == result.first.x && row == result.first.y) {
      return AppConstants.startCellColor; // Starting cell
    } else if (col == result.last.x && row == result.last.y) {
      return AppConstants.endCellColor; // Ending cell
    } else if (result.any((point) => point.x == col && point.y == row)) {
      return AppConstants.pathCellColor; // Cell in the shortest path
    } else if (value == AppConstants.blockedPositionValue) {
      return Colors.black; // Blocked cell
    } else {
      return Colors.white; // Default empty cell
    }
  }
}
