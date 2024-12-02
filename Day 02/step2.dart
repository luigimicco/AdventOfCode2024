import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int safeCount = 0;
  rows.forEach((row) {
    List<String> levels = row.split(" ");

    int unsafe = 0;
    int dir = 0;
    int prev = int.parse(levels[0]);
    dir = (int.parse(levels[1]) - prev).sign;

    if (dir == 1) {
      prev = int.parse(levels[0]);
      for (var i = 1; i < levels.length; i++) {
        int diff = int.parse(levels[i]) - prev;
        if (!(diff > 0 && diff < 4)) {
          unsafe++;
        }
        if (unsafe != 1) {
          prev = int.parse(levels[i]);
        }
      }
    } else {
      prev = int.parse(levels[levels.length - 1]);
      for (var i = levels.length - 2; i >= 0; i--) {
        int diff = int.parse(levels[i]) - prev;
        if (!(diff > 0 && diff < 4)) {
          unsafe++;
        }
        if (unsafe != 1) {
          prev = int.parse(levels[i]);
        }
      }
    }

    if (unsafe < 2) safeCount++;
  });

  print(safeCount);
}

List<String> getRows() {
  File file = File("test.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
