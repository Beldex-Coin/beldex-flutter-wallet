class SubaddressRow {
  const SubaddressRow(
      {required this.id, required this.address, required this.label});

  final int id;
  final String address;
  final String label;

  String getLabel() => label;
  String getAddress() => address;
  int getId() => id;
}
