String validatePostBody(String value) {
  if (value.length < 4) {
    return '4 character required for post';
  } else {
    return null;
  }
}