import 'dart:collection';
import '../models/point_model.dart';


class BFS {
  /// Get neighbors for a given position in the maze
  Map<PointModel, List<PointModel>> getNeighbours(List<List<String>> grid) {
    Map<PointModel, List<PointModel>> gridMap = {};

    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == '.') {
          PointModel currentPoint = PointModel(x: i, y: j);
          gridMap[currentPoint] ??= [];

          for (int rowOffset = -1; rowOffset <= 1; rowOffset++) {
            for (int colOffset = -1; colOffset <= 1; colOffset++) {
              if (rowOffset != 0 || colOffset != 0) {
                int newRow = i + rowOffset;
                int newCol = j + colOffset;

                if (isValidPosition(newRow, newCol, grid) && grid[newRow][newCol] == '.') {
                  gridMap[currentPoint]!.add(PointModel(x: newRow, y: newCol));
                }
              }
            }
          }
        }
      }
    }

    return gridMap;
  }

  bool isValidPosition(int row, int col, List<List<String>> grid) {
    return row >= 0 && row < grid.length && col >= 0 && col < grid[row].length;
  }


/// Find the shortest path in the maze
  List<PointModel> search(Map<PointModel, List<PointModel>> gridMap,
      PointModel start, PointModel end) {
    // If the start and end points match, return a list with one point - the start point
    if (start == end) {
      return [start];
    }

    Queue<PointModel> searchQueue = Queue();
    searchQueue.addAll(gridMap[start] ?? []);

    List<PointModel> searched = [];
    searched.add(start);

    while (searchQueue.isNotEmpty) {
      PointModel removed = searchQueue.removeFirst();
      if (!searched.contains(removed)) {
        if (removed == end) {
          searched.add(end);
          return searched;
        } else {
          searchQueue.addAll(gridMap[removed] ?? []);
          searched.add(removed);
        }
      }
    }

    // If no path is found, return an empty list
    return [];
  }

  /// Building a path based on search results
  List<PointModel> buildPath(List<PointModel> searched,
      Map<PointModel, List<PointModel>> gridMap, PointModel end) {
    if (!searched.contains(end)) {
      // If the endpoint was not found, return an empty list
      return [];
    }

    List<List<PointModel>> roads = [];

    for (int i = 0; i < searched.length; i++) {
      for (int j = i; j < searched.length; j++) {
        if (gridMap[searched[i]]!.contains(searched[j])) {
          roads.add([searched[i], searched[j]]);
        }
      }
    }

    PointModel searchedValue = end;
    List<PointModel> roadReverse = [end];

    for (int i = 0; i < roads.length; i++) {
      for (int j = 0; j < roads.length; j++) {
        if (roads[j][1] == searchedValue) {
          roadReverse.add(roads[j][0]);
          searchedValue = roads[j][0];
        }
      }
    }

    return List.from(roadReverse.reversed);
  }

  List<PointModel> getShortestPath(
      List<List<String>> field, PointModel startPoint, PointModel endPoint) {

    Map<PointModel, List<PointModel>> gridMap = getNeighbours(field);
    List<PointModel> searched = search(gridMap, startPoint, endPoint);
    List<PointModel> path = buildPath(searched, gridMap, endPoint);

    return path;
  }
}
