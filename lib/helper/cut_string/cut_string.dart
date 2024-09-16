String cutString(String inputString) {
  int index = inputString.indexOf(' ');
  if (index != -1) {
    return inputString.substring(0, index).trim();
  } else {
    return inputString;
  }
}
