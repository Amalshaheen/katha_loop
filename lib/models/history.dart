class HistoryModel {
  final String role;
  final String message;

  HistoryModel({required this.message, required this.role});

  Map<String, String> toMap() {
    return {
      "message":message,
      "role":role
    };
  }
}
