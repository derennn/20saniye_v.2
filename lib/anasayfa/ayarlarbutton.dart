import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/globals/globals.dart';
import 'package:yirmibir_saniye/menuyedon.dart';
import 'package:yirmibir_saniye/globals/categories.dart' as categories;
import 'package:shared_preferences/shared_preferences.dart';

class Ayarlar extends StatelessWidget {
  const Ayarlar({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: defaultGreyColor),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AyarlarSayfasi();
              },
            ),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: arkaplanColor,
        ),
        child: Text(
          content,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({
    Key? key,
  }) : super(key: key);

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: arkaplanColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const MenuyeDon(),
          const Positioned(
            top: 65,
            left: 0,
            right: 0,
            child: Divider(
              color: Colors.white,
            ),
          ),
          SoundEffects(),
          const Positioned(
            top: 150,
            left: 30,
            child: Text(
              'Soru Kategorileri',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
          Categories(category: 0, topgap: 0),
          Categories(category: 1, topgap: 1),
          Categories(category: 2, topgap: 2),
          Categories(category: 3, topgap: 3),
          Categories(category: 4, topgap: 4),
          Categories(category: 5, topgap: 5),
          Categories(category: 6, topgap: 6),
          Categories(category: 7, topgap: 7),
          Categories(category: 8, topgap: 8),
          Categories(category: 9, topgap: 9),
        ],
      ),
    );
  }
}

class Categories extends StatefulWidget {
  Categories({
    Key? key,
    required this.category,
    required this.topgap,
  }) : super(key: key);

  int category;
  double topgap;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  void initState() {
    super.initState();
    print('${categories.categoriesMap[widget.category]}');
  }

  Future<void> _categoriesToggleSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      categories.categoriesMap[widget.category] = !categories.categoriesMap[widget.category];
      prefs.setBool('${widget.category}', categories.categoriesMap[widget.category]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 180 + (widget.topgap * 35),
      left: 40,
      right: 30,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${widget.category}',
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Switch(
                value: categories.categoriesMap[widget.category],
                onChanged: (bool newValue) {
                  _categoriesToggleSwitch();
                },
                activeTrackColor: Colors.green,
                thumbColor: MaterialStateProperty.all(Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SoundEffects extends StatefulWidget {
  const SoundEffects({
    Key? key,
  }) : super(key: key);

  @override
  State<SoundEffects> createState() => _SoundEffectsState();
}

class _SoundEffectsState extends State<SoundEffects> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      left: 30,
      right: 30,
      child: SizedBox(
        child: Row(
          children: [
            const Text(
              'Ses efektleri',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Switch(
              value: categories.soundeffects,
              onChanged: (bool newValue) {
                setState(() {
                  categories.soundeffects = newValue;
                });
              },
              activeTrackColor: Colors.green,
              thumbColor: MaterialStateProperty.all(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
