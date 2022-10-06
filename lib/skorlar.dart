library skorlar;

late List<int> globalSkorTablosuOyuncuSayisiList;
late Map globalSkorTablosuMap;

Map<int, int> globalSkorTablosuFunc () {
  late Map<int, int> tablo = {
    for (var i in globalSkorTablosuOyuncuSayisiList) globalSkorTablosuOyuncuSayisiList[i -
        1]: 0,
  };
  return tablo;
}