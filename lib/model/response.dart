class Products {
  final int id;
  final String name;
  final String price;

  Products({this.id, this.name, this.price});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(id: json['id'], name: json['name'], price: json['price']);
  }
}

class CustomersModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String role;
  final String password;

  CustomersModel({this.id, this.email, this.firstName, this.lastName, this.username, this.role, this.password});

  factory CustomersModel.fromJson(Map<String, dynamic> customersJson) {
    return CustomersModel(
      id: customersJson['id'],
      role: customersJson['role'],
      firstName: customersJson['first_name'],
      lastName: customersJson['last_name'],
      username: customersJson['username'],
      email: customersJson['email'],
      password: customersJson['password'],
    );
  }


}

class Category {
  final int id;
  final String name;
  final String display;
  final int parent;

  Category({this.id, this.name, this.display, this.parent});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        display: json['display'],
        parent: json['parent']);
  }
}
