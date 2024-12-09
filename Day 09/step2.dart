/* import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  String row = rows[0];

  List<List<int>> disk = [];
  for (var i = 0; i < row.length; i = i + 2) {
    int block = int.parse(row.substring(i, i + 1));
    int free = 0;
    if (i + 1 < row.length) free = int.parse(row.substring(i + 1, i + 2));
    disk.add([block, free]);
  }
  print(disk);

  int left = disk.length;
  List<String> space = [];
  for (var i = 0; i < disk.length; i++) {
    for (var j = 0; j < disk[i][0]; j++) {
      space.add(i.toString());
    }
    bool doTest = true;

    while (doTest && (left > i)) {
      left--;
      if (left >= 0 && disk[left][0] <= disk[i][1]) doTest = false;
    }

    if (left > i) {
      for (var j = 0; j < disk[left][0]; j++) {
        space.add(left.toString());
      }
      disk[i][1] = disk[i][1] - disk[left][0];
      disk[left][1] = disk[left][0];
      disk[left][0] = 0;
    }

    for (var j = 0; j < disk[i][1]; j++) {
      space.add(".");
    }
  }

  print(space.join());

  int score = 0;
  for (var i = 0; i < space.length; i++) {
    if (space[i] != ".") score += i * int.parse(space[i]);
  }

  print(score);
}

List<String> getRows() {
  File file = File("test.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
 */

import 'dart:io';

void main() {
  List<String> rows = getRows();

  String row = rows[0];
  int score = 0;

  List<List<int>> disk = [];
  String space = "";
  for (var i = 0; i < row.length; i = i + 2) {
    int block = int.parse(row.substring(i, i + 1));
    int free = 0;
    if (i + 1 < row.length) free = int.parse(row.substring(i + 1, i + 2));
    int pos = space.length;
    space += disk.length.toString() * block;
    space += "." * free;
    disk.add([block, free, pos]);
  }
  print(space);

  for (int i = disk.length - 1; i >= 0; i--) {
    String pattern = i.toString() * disk[i][0];

    int pos = disk[i][2];

    int left = space.indexOf("." * pattern.length);
    if (left != -1 && left < pos) {
      space = space.replaceRange(left, left + pattern.length, pattern);
      space =
          space.replaceRange(pos, pos + pattern.length, "." * pattern.length);
    }
  }

  print(space);

  List<String> raw = [];
  raw = space.split("");

  for (var i = 0; i < raw.length; i++) {
    if (raw[i] != ".") score += i * int.parse(raw[i]);
  }

  print(score);
}

int findSpace(String row, int len) {
  return row.indexOf("." * len);
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
