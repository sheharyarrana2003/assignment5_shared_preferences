class ContactList {
  final String name;
  final String number;

  ContactList({required this.name, required this.number});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
    };
  }

  factory ContactList.fromMap(Map<String, dynamic> map) {
    return ContactList(
      name: map['name'],
      number: map['number'],
    );
  }
}
