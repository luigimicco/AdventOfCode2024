import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int score = 0;
  List<List<int>> moves = [
    [1, 0], // E
    [1, -1], // NE
    [0, -1], // N
    [-1, -1], // NW
    [-1, 0], // W
    [-1, 1], // SW
    [0, 1], // S
    [1, 1], // SE
  ];

  for (var i = 0; i < nRows; i++) {
    String row = rows[i].trim();
    for (var j = 0; j < row.length; j++) {
      moves.forEach((item) {
        if (checkNeighbours(rows, i, j, item)) {
          score++;
        }
      });
    }
  }

  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}

bool checkNeighbours(List<String> rows, int row, int col, List<int> moves) {
  String result = "";

  int len = rows[row].trim().length;
  result = rows[row].substring(col, col + 1);

  if (result == "X") {
    bool border = false;
    if ((moves[0] == 1) && !(col + 4 <= len)) border = true;
    if ((moves[0] == -1) && !(col - 3 >= 0)) border = true;
    if ((moves[1] == -1) && !(row - 3 >= 0)) border = true;
    if ((moves[1] == 1) && !(row + 3 < rows.length)) border = true;

    if (!border) {
      result += rows[row + 1 * moves[1]]
          .substring(col + 1 * moves[0], col + 1 * moves[0] + 1);
      result += rows[row + 2 * moves[1]]
          .substring(col + 2 * moves[0], col + 2 * moves[0] + 1);
      result += rows[row + 3 * moves[1]]
          .substring(col + 3 * moves[0], col + 3 * moves[0] + 1);
    }
  }
  return result == "XMAS";
}
