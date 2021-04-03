class User {
  final String fullName;
  final String phoneNumber;
  final String gender;
  final String bloodGroup;
  final DateTime dateOfBirth;
  final List tokens;

  User(this.fullName, this.phoneNumber, this.gender,
      this.bloodGroup, this.dateOfBirth, this.tokens);

  factory User.fromMap(Map<String, dynamic> user) {
    return User(user['fullName'], user['phoneNumber'], user['gender'], user['bloodGroup'], user['dateOfBirth'].toDate(), user['tokens']);
  }



}