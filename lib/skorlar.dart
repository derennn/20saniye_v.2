library skorlar;

late List<int> globalSkorTablosuOyuncuSayisiList;

late Map globalSkorTablosuMap = {
  for (var i in globalSkorTablosuOyuncuSayisiList) globalSkorTablosuOyuncuSayisiList[i-1] : 0,
};