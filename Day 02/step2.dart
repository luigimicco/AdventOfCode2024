import 'dart:io';

void main() {
  List<String> rows = getRows();

  int safeCount = 0;
  rows.forEach((row) {
    List<String> levels = row.split(" ");

    List<int> report = [];
    for (var j = -1; j < levels.length; j++) {
      report = [];
      for (var i = 0; i < levels.length; i++) {
        if (i != j) report.add(int.parse(levels[i]));
      }
      if (isSafe(report)) {
        safeCount++;
        j = levels.length;
      }
    }
  });

  print(safeCount);
}

bool isSafe(List<int> report) {
  bool safe = true;
  int dir = 0;
  int prev = report[0];
  dir = (report[1] - prev).sign;
  for (var i = 1; i < report.length && safe; i++) {
    int diff = (report[i] - prev) * dir;

    if (diff <= 0 || diff > 3) {
      safe = false;
    }
    prev = report[i];
  }

  return safe;
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
