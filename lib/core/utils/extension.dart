extension StringExtension on String {
  String query(Map<String, dynamic> querys) {
    final List<String> key = querys.keys.toList();
    final List<dynamic> value = querys.values.toList();
    final List merging = [];

    for (var i = 0; i < key.length; i++) {
      if (i > 0) {
        merging.add('&');
      }

      merging.add(key[i]);
      merging.add('=');
      merging.add(value[i]);
    }

    return "$this?${merging.join()}";
  }
}
