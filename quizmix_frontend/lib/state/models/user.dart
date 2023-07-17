class User {
  const User({
    required this.email,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.image,
    required this.isActive,
    required this.createdOn,
  });

  final String email;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? image;
  final bool isActive;
  final DateTime createdOn;

  /// Base user creation; call this if you need to reference an empty user.
  User.base()
      : email = '',
        firstName = '',
        middleName = null,
        lastName = '',
        image = null,
        isActive = false,
        createdOn = DateTime.now();
}
