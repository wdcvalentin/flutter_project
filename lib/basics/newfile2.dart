void main(List<String> arguments) {
  List<int> list = <int>[25, 49, 79, 12];
  list.sort();
  // list.add(5);
  // list[1];
  list.sort((a, b) => a);
  var liste = list.map((e) => e * 2);
  liste.where((element) => element % 2 == 0);
  print(liste);
  // print(list);

  // Set<int> set = { 1, 2, 3, 4, 1};

  // Map<String, int> map = {
  //   "clé" : 1
  // };

}

