class AccountRow {
  const AccountRow({required this.id, required this.label});

  final int id;
  final String label;

  String getLabel() => label;
  int getId() => id;
}
