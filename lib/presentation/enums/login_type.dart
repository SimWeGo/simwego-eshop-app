enum LoginType {
  email("email"),
  phoneNumber("phone"),
  emailAndPhone("email_phone");

  const LoginType(this.type);

  final String type;

  static LoginType? fromValue({required String value}) {
    LoginType? result;
    LoginType.values.forEach((LoginType type) {
      if (type.type.toLowerCase() == value.toLowerCase()) {
        result = type;
      }
    });
    return result;
  }
}
