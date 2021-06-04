String validateUsername(String value) {
  if (value.length < 4) {
    return '4 character required for username';
  } else {
    return null;
  }
}