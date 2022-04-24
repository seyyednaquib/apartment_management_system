class ServiceModel {
  final String serviceId;
  final String serviceTitle;
  final String content;
  final String workingHours;

  ServiceModel(
      {required this.serviceId,
      required this.serviceTitle,
      required this.content,
      required this.workingHours});

  factory ServiceModel.fromRTDB(Map<String, dynamic> data) {
    return ServiceModel(
        serviceId: data['serviceId'] ?? 'unk',
        serviceTitle: data['service'] ?? 'unk',
        content: data['content'] ?? 'unk',
        workingHours: data['workingHours'] ?? 'unk');
  }
}

class BookServiceModel {
  final String serviceId;
  final String residentId;
  final String bookindDateAndTime;
  final String status;

  BookServiceModel(
      {required this.serviceId,
      required this.residentId,
      required this.bookindDateAndTime,
      required this.status});

  factory BookServiceModel.fromRTDB(Map<String, dynamic> data) {
    return BookServiceModel(
        serviceId: data['serviceId'] ?? 'unk',
        residentId: data['residentId'] ?? 'unk',
        bookindDateAndTime: data['bookindDateAndTime'] ?? 'unk',
        status: data['status'] ?? 'unk');
  }
}
