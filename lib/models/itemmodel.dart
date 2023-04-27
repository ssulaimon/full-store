class ItemModel {
  String name;
  String price;
  String description;
  String category;
  String ingredients;
  String image;

  ItemModel({
    required this.category,
    required this.description,
    required this.image,
    required this.ingredients,
    required this.name,
    required this.price,
  });

  toJson() => {
        'name': name,
        'price': price,
        'category': category,
        'image': image,
        'ingredients': ingredients,
        'description': description,
      };
}
