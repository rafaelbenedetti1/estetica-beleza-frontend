coalesceEmpty(String obj1, String obj2) {
  if (obj1 == null || obj1.isEmpty) {
    return obj2;
  }
  return obj1;
}