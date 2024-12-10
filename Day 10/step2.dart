import 'dart:io';

void main() {
  List<String> rows = getRows();

  List<List<String>> matrix = [];

  Map<int, dynamic> mappa = {};

  int q = 0;
  for (int i = 0; i < rows.length; i++) {
    int index = rows[i].indexOf("0");
    while (index != -1) {
      mappa[q] = [];
      mappa[q]!.add([i, index]);
      index = rows[i].indexOf("0", index + 1);
      q++;
    }
    matrix.add(rows[i].split(""));
  }

  int score = 0;
  for (int i = 0; i < mappa.length; i++) {
    List<int> start = mappa[i]!.first;
    check(matrix, start, 1, mappa[i]!);
    score = score + mappa[i].toString().split(",").length - 2;
  }

  print(score);
}

bool check(
    List<List<String>> matrix, List<int> pos, int next, List<dynamic> trail) {
  int row = pos[0];
  int col = pos[1];
  String char = next.toString();

  bool result = false;
  if (next == 10) {
    trail.add("[" + row.toString() + "|" + col.toString() + "]");
    return true;
  }

  if (pos[0] == -1 || pos[1] == -1) return false;

  if ((row - 1 >= 0) && (matrix[row - 1][col] == char)) {
    if (check(matrix, [row - 1, col], next + 1, trail)) result = true;
  }
  if ((col - 1 >= 0) && (matrix[row][col - 1] == char)) {
    if (check(matrix, [row, col - 1], next + 1, trail)) result = true;
  }
  if ((col + 1 < matrix[row].length) && (matrix[row][col + 1] == char)) {
    if (check(matrix, [row, col + 1], next + 1, trail)) result = true;
  }
  if ((row + 1 < matrix.length) && (matrix[row + 1][col] == char)) {
    if (check(matrix, [row + 1, col], next + 1, trail)) result = true;
  }

  return result;
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
