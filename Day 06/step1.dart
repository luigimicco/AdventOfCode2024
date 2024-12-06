import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int posR = 0;
  int posC = 0;
  List<List<String>> matrix = [];
  for (int i = 0; i < nRows; i++) {
    matrix.add([]);
    int len = rows[i].trim().length;
    for (int j = 0; j < len; j++) {
      matrix[i].add(rows[i].substring(j, j + 1));
      if (matrix[i][j] == "^") {
        posR = i;
        posC = j;
      }
    }
  }

  int visited = move(matrix, posR, posC);

  print(visited);
}

int move(List<List<String>> matrix, int row, int col) {
  int score = 0;

  int height = matrix.length;
  int width = matrix[0].length;

  bool step = true;

  do {
    while (row > 0 && matrix[row - 1][col] != "#") {
      row--;
      if (matrix[row][col] != "X") score++;
      matrix[row][col] = "X";
    }
    if (row == 0) step = false;
    while (step && (col + 1 < width) && matrix[row][col + 1] != "#") {
      col++;
      if (matrix[row][col] != "X") score++;
      matrix[row][col] = "X";
    }
    if (col + 1 == width) step = false;
    while (step && (row + 1 < height) && matrix[row + 1][col] != "#") {
      row++;
      if (matrix[row][col] != "X") score++;
      matrix[row][col] = "X";
    }
    if (row + 1 == height) step = false;
    while (step && (col > 0) && matrix[row][col - 1] != "#") {
      col--;
      if (matrix[row][col] != "X") score++;
      matrix[row][col] = "X";
    }
    if (col == 0) step = false;
  } while (step);

  return score;
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
