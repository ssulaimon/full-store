class ItemModel {
  String name;
  String price;
  String description;
  String category;
  String ingredients;
  String image;
  String? id;
  String? email;
  String? address;
  String? status;

  ItemModel({
    required this.category,
    required this.description,
    required this.image,
    required this.ingredients,
    required this.name,
    required this.price,
    this.id,
    this.email,
    this.address,
    this.status,
  });

  toJson() => {
        'name': name,
        'price': price,
        'category': category,
        'image': image,
        'ingredients': ingredients,
        'description': description,
      };

  addToOrder() => {
        'name': name,
        'price': price,
        'category': category,
        'image': image,
        'ingredients': ingredients,
        'description': description,
        'email': email,
        'address': address,
        'status': 'pending'
      };
}
