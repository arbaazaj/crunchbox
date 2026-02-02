class Account {
  final String id;
  final String name;
  final String email;

  const Account({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] ?? '',
      name: map['user_metadata']?['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_metadata': {'name': name},
      'email': email,
    };
  }

}