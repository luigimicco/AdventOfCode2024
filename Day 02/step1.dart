import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int safeCount = 0;
  rows.forEach((row) {
    List<String> levels = row.split(" ");

    bool safe = true;
    int dir = 0;
    int prev = int.parse(levels[0]);
    dir = (int.parse(levels[1]) - prev).sign;
    for (var i = 1; i < levels.length; i++) {
      int diff = int.parse(levels[i]) - prev;

      if (!((diff > 0 && diff < 4 && dir == 1) ||
          (diff < 0 && diff > -4 && dir == -1))) {
        safe = false;
      }
      prev = int.parse(levels[i]);
    }
    if (safe) safeCount++;
  });

  print(safeCount);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
