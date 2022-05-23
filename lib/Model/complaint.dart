import 'package:get/get.dart';

class ComplaintModel {
  final String complaintId;
  final String residentId;
  final String complaintContent;
  final String complaintTitle;
  final String dateCreated;
  final String complaintRespond;

  ComplaintModel(
      {required this.complaintId,
      required this.residentId,
      required this.complaintContent,
      required this.complaintTitle,
      required this.dateCreated,
      required this.complaintRespond});

  factory ComplaintModel.fromRTDB(Map<String, dynamic> data) {
    return ComplaintModel(
        complaintId: data['complaintId'] ?? 'unknown',
        residentId: data['residentId'] ?? 'unknown',
        complaintContent: data['complaintContent'] ?? 'unknown',
        complaintTitle: data['complaintTitle'] ?? 'unknown',
        dateCreated: data['dateCreated'] ?? 'unknown',
        complaintRespond: data['ComplaintRespond'] ?? 'unk');
  }
}
