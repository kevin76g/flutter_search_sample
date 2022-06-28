const columnId = 'id';
const columnName = 'name';
const columnPrice = 'price';
const columnQuantity = 'quantity';

class Fruit {
  final int id;
  final String name;
  final int price;
  final int quantity;

  Fruit({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      columnId: id,
      columnName: name,
      columnPrice: price,
      columnQuantity: quantity,
    };
  }

  @override
  String toString() {
    return 'Fruits{$columnId:$id, $columnName:$name, $columnPrice: $quantity, $columnQuantity: $quantity}';
  }
}
