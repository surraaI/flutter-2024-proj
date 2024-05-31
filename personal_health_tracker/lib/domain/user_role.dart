enum UserRole {
  admin,
  user,
}

extension UserRoleExtension on UserRole {
  static UserRole fromString(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      default:
        throw Exception('Invalid user role');
    }
  }

  String toJson() {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.user:
        return 'user';
    }
  }
}
