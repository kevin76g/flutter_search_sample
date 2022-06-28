import 'package:flutter_search_sample/common/importer.dart';

class FruitService {
  Future<List<Fruit>> getFruitsByKeyword(String keyword) async {
    FruitHelper fruitHelper = FruitHelper();
    List<Fruit> fruits = await fruitHelper.getFruits();

    List<Fruit> hitFruits = [];

    for (var item in fruits) {
      if (item.name.contains(keyword)) {
        hitFruits.add(item);
      }
    }

    return hitFruits;
  }
}
