import 'dart:io';

void main() {
  List<String> rows = getRows();
  int nRows = rows.length;

  int score = 0;
  List<String> row = rows[0].trim().split(" ");

  Map cache = {};

  row.forEach((element) {
    score += parse(element, 25, cache);
    print(score);
  });

  print(score);
}

int parse(String value, int times, Map cache) {
  if (times == 0) return 1;
  if (value == "0") {
    if (cache.containsKey("1|" + (times - 1).toString())) {
      return cache["1|" + (times - 1).toString()];
    } else {
      int count = parse("1", times - 1, cache);
      cache["1|" + (times - 1).toString()] = count;
      return count;
    }
  } else if (value.length % 2 == 0) {
    int left = 0;
    num right = 0;

    if (cache.containsKey(
        value.substring(0, value.length ~/ 2) + "|" + (times - 1).toString())) {
      left = cache[
          value.substring(0, value.length ~/ 2) + "|" + (times - 1).toString()];
    } else {
      left = parse(value.substring(0, value.length ~/ 2), times - 1, cache);
      cache[value.substring(0, value.length ~/ 2) +
          "|" +
          (times - 1).toString()] = left;
    }
    if (cache.containsKey(
        int.parse(value.substring(value.length ~/ 2)).toString() +
            "|" +
            (times - 1).toString())) {
      right = cache[int.parse(value.substring(value.length ~/ 2)).toString() +
          "|" +
          (times - 1).toString()];
    } else {
      right = parse(int.parse(value.substring(value.length ~/ 2)).toString(),
          times - 1, cache);
      cache[int.parse(value.substring(value.length ~/ 2)).toString() +
          "|" +
          (times - 1).toString()] = right;
    }
    return (left + right).toInt();
  } else if (cache.containsKey(
      (int.parse(value) * 2024).toString() + "|" + (times - 1).toString())) {
    return cache["1|" + (times - 1).toString()];
  } else {
    int count = parse((int.parse(value) * 2024).toString(), times - 1, cache);
    cache[(int.parse(value) * 2024).toString() + "|" + (times - 1).toString()] =
        count;
    return count;
  }
}

List<String> getRows() {
  File file = File("data.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
