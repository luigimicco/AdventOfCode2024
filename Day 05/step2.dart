import 'dart:io';

void main() {
  List<String> ordering = getOrdering();
  List<String> updates = getUpdates();

  Map<int, List<int>> orders = {};
  ordering.forEach((order) {
    int first = int.parse(order.split("|")[0]);
    int second = int.parse(order.split("|")[1]);
    if (!orders.keys.contains(first)) orders[first] = [];
    orders[first]!.add(second);
  });

  int score = 0;
  updates.forEach((row) {
    List<String> pages = row.split(",");

    bool isValid = true;
    int len = pages.length;
    for (var i = 0; i < len; i++) {
      if (orders.keys.contains(int.parse(pages[i].toString()))) {
        List<int> check = orders[int.parse(pages[i].toString())]!;
        for (var k = i + 1; k < len; k++) {
          if (!check.contains(int.parse(pages[k].toString()))) {
            String temp = pages[i];
            pages[i] = pages[k];
            pages[k] = temp;
            isValid = false;
          }
        }
      }
      if (orders.keys.contains(int.parse(pages[i].toString()))) {
        List<int> check = orders[int.parse(pages[i].toString())]!;

        for (var k = 0; k < i; k++) {
          if (check.contains(int.parse(pages[k].toString()))) {
            String temp = pages[i];
            pages[i] = pages[k];
            pages[k] = temp;
            isValid = false;
          }
        }
      }
    }
    if (!isValid) {
      score += int.parse(pages[len ~/ 2]);
    }
  });

  print(score);
}

List<String> getOrdering() {
  File file = File("data1.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}

List<String> getUpdates() {
  File file = File("data2.txt");
  var fileContent = file.readAsStringSync();
  return fileContent.split("\n");
}
