class Service {
  final String id;
  final String title;
  final String description;
  final double price;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String nif;
  final String balance;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.nif,
      required this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      nif: json['nif'],
      balance: json['balance'],
    );
  }
}

class Transaction {
  final String id;
  final double amount;

  Transaction({required this.id, required this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
    );
  }
}
