class Expense {
  final String startDate;
  final String endDate;
  final String title;
  final String approver;
  final String costCenter;

  Expense({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.approver,
    required this.costCenter,
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'title': title,
      'approver': approver,
      'costCenter': costCenter,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      title: json['title'] ?? '',
      approver: json['approver'] ?? '',
      costCenter: json['costCenter'] ?? '',
    );
  }
}
