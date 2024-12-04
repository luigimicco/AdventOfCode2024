import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int score = 0;

  for (var i = 0; i < nRows; i++) {
    String row = rows[i].trim();
    for (var j = 0; j < row.length; j++) {
      if (neighbours(rows, i, j)) {
        score++;
      }
    }
  }

  print(score);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}

bool neighbours(List<String> rows, int row, int col) {
  bool result = false;

  int len = rows[row].trim().length;

  if (rows[row].substring(col, col + 1) == "A") {
    if ((col > 0) && (col + 1 <= len) && (row > 0) && (row + 1 < rows.length)) {
      if ((rows[row - 1].substring(col - 1, col) == "M") &&
          (rows[row - 1].substring(col + 1, col + 2) == "S") &&
          (rows[row + 1].substring(col - 1, col) == "M") &&
          (rows[row + 1].substring(col + 1, col + 2) == "S")) {
        result = true;
      } else if ((rows[row - 1].substring(col - 1, col) == "M") &&
          (rows[row - 1].substring(col + 1, col + 2) == "M") &&
          (rows[row + 1].substring(col - 1, col) == "S") &&
          (rows[row + 1].substring(col + 1, col + 2) == "S")) {
        result = true;
      } else if ((rows[row - 1].substring(col - 1, col) == "S") &&
          (rows[row - 1].substring(col + 1, col + 2) == "S") &&
          (rows[row + 1].substring(col - 1, col) == "M") &&
          (rows[row + 1].substring(col + 1, col + 2) == "M")) {
        result = true;
      } else if ((rows[row - 1].substring(col - 1, col) == "S") &&
          (rows[row - 1].substring(col + 1, col + 2) == "M") &&
          (rows[row + 1].substring(col - 1, col) == "S") &&
          (rows[row + 1].substring(col + 1, col + 2) == "M")) {
        result = true;
      }
    }
  }

  return result;
}
