class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phone;
  final String alternativePhone;
  final String location;
  final String address;
  final int age;
  final bool accountStatus; // Boolean attribute for account status

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.alternativePhone,
    required this.location,
    required this.address,
    required this.age,
    required this.accountStatus, // Account status is a boolean
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'alternativePhone': alternativePhone,
      'location': location,
      'address': address,
      'age': age,
      'accountStatus': accountStatus,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      alternativePhone: map['alternativePhone'] ?? '',
      location: map['location'] ?? '',
      address: map['address'] ?? '',
      age: map['age'] ?? 0, // Defaulting age to 0 if not available
      accountStatus: map['accountStatus'] ?? false,
    );
  }
}
