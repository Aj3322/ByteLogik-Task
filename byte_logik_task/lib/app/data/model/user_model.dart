class UserModel {
  String? id;                  // Firestore document ID
  String username;
  String email;// Username of the user
  int counterValue;             // Counter value to track button clicks
  DateTime? lastCounterUpdate;  // Last time the counter was updated
  DateTime? lastLogin;          // Last time the user logged in
  DateTime? lastPasswordChange; // Last time the user changed their password
  String? accountStatus = 'active';         // Account status: Active, Suspended, etc.
  DateTime? createdAt;          // Account creation timestamp

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.counterValue,
    this.lastCounterUpdate,
    this.lastLogin,
    this.lastPasswordChange,
    this.accountStatus,
    this.createdAt,
  });

  // Convert UserModel object to a map (for saving to Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "email":email,
      'username': username,
      'counterValue': counterValue,
      'lastCounterUpdate': lastCounterUpdate.toString(),
      'lastLogin': lastLogin.toString(),
      'lastPasswordChange': lastPasswordChange.toString(),
      'accountStatus': accountStatus.toString(),
      'createdAt': createdAt.toString(),
    };
  }

  // Create a UserModel from a Firestore document snapshot
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email:  map['email'] ?? '',
      username: map['username'] ?? '',
      counterValue: map['counterValue'] ?? 0,
      lastCounterUpdate: (map['lastCounterUpdate'] != 'null')
          ? DateTime.parse(map['lastCounterUpdate'])
          : null,
      lastLogin: (map['lastLogin'] != 'null')
          ? DateTime.parse(map['lastLogin'])
          : null,
      lastPasswordChange: (map['lastPasswordChange'] != 'null')
          ? DateTime.parse(map['lastPasswordChange'])
          : null,
      accountStatus: map['accountStatus'] ?? 'Active',
      createdAt: (map['createdAt'] != 'null')
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }
}
void main() {
  String dateTimeString = '2024-09-28 04:20:05.343135';

  // Parsing the string to DateTime
  DateTime parsedDateTime = DateTime.parse(dateTimeString);

  print(parsedDateTime.day); // Output: 2024-09-28 04:20:05.343135
}