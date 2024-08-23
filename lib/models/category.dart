class Category {
  final int id;
  final String name;
  final String image;
  Category({required this.id, required this.name,required this.image});

  // Convert a Category object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image
    };
  }

  // Convert a Map object into a Category object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image']
    );
  }
}
