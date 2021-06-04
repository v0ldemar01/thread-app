String validateEmail(String value) {
    Pattern pattern =
      r'^(?:\+38)?(?:\(044\)[ .-]?[0-9]{3}[ .-]?[0-9]{2}[ .-]?[0-9]{2}|044[ .-]?[0-9]{3}[ .-]?[0-9]{2}[ .-]?[0-9]{2}|044[0-9]{7})$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Phone cannot be empty';
    } else if (!regex.hasMatch(value)) {
    return 'Phone format is invalid';
  } else {
    return null;
  }
  }