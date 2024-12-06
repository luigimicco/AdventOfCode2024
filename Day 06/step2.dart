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

  int loop = 0;

  for (int i = 0; i < nRows; i++) {
    int len = rows[i].trim().length;
    for (int j = 0; j < len; j++) {
      if (matrix[i][j] != "#" && matrix[i][j] != "^") {
        List<List<String>> temp = [];
        for (int k = 0; k < nRows; k++) {
          temp.add([]);
          temp[k] = [...matrix[k]];
        }
        temp[i][j] = "#";
        if (i == 8 && j == 3) {
          print(i.toString() + " " + j.toString());
        }

        if (checkLoop(temp, posR, posC)) {
          print(i.toString() + " " + j.toString());
          loop++;
        }
      }
    }
  }

  print(loop);
}

bool checkLoop(List<List<String>> matrix, int row, int col) {
  bool loop = false;

  int height = matrix.length;
  int width = matrix[0].length;

  bool step = true;
  String checks = "";

  do {
    checks += "|" + row.toString() + "," + col.toString();

    while (row > 0 && matrix[row - 1][col] != "#") {
      row--;
    }
    if (row == 0) step = false;
    while (step && (col + 1 < width) && matrix[row][col + 1] != "#") {
      col++;
    }
    if (col + 1 == width) step = false;
    while (step && (row + 1 < height) && matrix[row + 1][col] != "#") {
      row++;
    }
    if (row + 1 == height) step = false;
    while (step && (col > 0) && matrix[row][col - 1] != "#") {
      col--;
    }
    if (col == 0) step = false;
    if (checks.contains("|" + row.toString() + "," + col.toString()))
      loop = true;
  } while (step && !loop);

  return loop;
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
