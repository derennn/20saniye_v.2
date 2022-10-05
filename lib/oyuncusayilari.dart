import 'dart:math';

List<String> listoflists =[];

class OyuncuSayilariClass {

  int oyuncuadedi;

  OyuncuSayilariClass({required this.oyuncuadedi});

  Random random = Random();

  List<int> oyuncuIsimleriFunc() {

    List<int> oyunculist = [];
    String kombinasyon1;
    String kombinasyon2;
    int oyuncuAdediFaktoriyel = 1;
    int oyuncuAdediKombBolen = 1;

    for (int i = 1; i <= oyuncuadedi; i++) {
      oyuncuAdediFaktoriyel *= i;
    }
    for (int i = 1; i <= oyuncuadedi-2; i++) {
      oyuncuAdediKombBolen *= i;
    }
    double oyuncuAdediIkiliKombinasyon = oyuncuAdediFaktoriyel/oyuncuAdediKombBolen;

    while (true) {
      oyunculist.clear();
      int random1 = random.nextInt(oyuncuadedi)+1;
      oyunculist.add(random1);
      int random2 = random.nextInt(oyuncuadedi)+1;
      oyunculist.add(random2);
      kombinasyon1 ='[$random1,$random2]';
      kombinasyon2 ='[$random2,$random1]';
      if (oyuncuAdediIkiliKombinasyon.toInt() == listoflists.length) {
//       print('${listoflists.length} yukaridaki');
       listoflists.clear();
      } else {
        if (listoflists.contains(kombinasyon1)) {
        print('infinity loop');
        continue;
      } else if (listoflists.contains(kombinasyon2)) {
        print('infinity poop');
        continue;
      }
      }
      if (random1!=random2) {
        break;
      }
    }
//    print('$listoflists');
    listoflists.add(kombinasyon1);
    listoflists.add(kombinasyon2);
//    print('$listoflists');
//    print('$oyuncuAdediFaktoriyel');
//    print('${oyuncuAdediIkiliKombinasyon.toInt()}');
//    print('${listoflists.length}');
//    print('$listoflists');
    return oyunculist;
  }
}