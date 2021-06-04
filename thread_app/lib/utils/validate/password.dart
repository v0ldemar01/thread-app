String validatePassword(String value) {
  if (value.length < 8) {
    return '8 character required for password';
  } else {
    return null;
  }
}