class Patient {
  final String id;
  final String name;
  final String condition;
  final String disease;
  final String location;
  final String date;
  final String email;
  bool flagged;

  Patient({
    required this.id,
    required this.name,
    required this.condition,
    required this.disease,
    required this.location,
    required this.date,
    required this.email,
    this.flagged = false,
  });
}