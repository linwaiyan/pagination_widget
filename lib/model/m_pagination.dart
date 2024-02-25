class Beer {
  String name;
  Beer({
    required this.name,
  });
  factory Beer.fromMap({required Map<String, dynamic> data}) {
    return Beer(
      name: data['name'] ?? '',
    );
  }
}
