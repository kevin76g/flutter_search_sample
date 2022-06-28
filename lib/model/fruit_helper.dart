import 'package:flutter_search_sample/common/importer.dart';

class FruitHelper {
  Future<List<Fruit>> getFruits() async {
    List<Fruit> fruits = [];

    for (var item in fruitRawData) {
      fruits.add(Fruit(
          id: int.parse(item[columnId].toString()),
          name: item[columnName].toString(),
          price: int.parse(item[columnPrice].toString()),
          quantity: int.parse(item[columnQuantity].toString())));
    }
    return fruits;
  }
}
