class VisitorModel {
  final String visitorId;
  final String expectedEntryTime;
  final String entryTime;
  final String visitorIcPassport;
  final String visitorName;
  final String visitorPreRegis;
  final String visitorValidate;
  final String dateCreated;

  VisitorModel({
    required this.visitorId,
    required this.entryTime,
    required this.expectedEntryTime,
    required this.visitorIcPassport,
    required this.visitorName,
    required this.visitorPreRegis,
    required this.visitorValidate,
    required this.dateCreated,
  });

  factory VisitorModel.fromRTDB(Map<String, dynamic> data) {
    return VisitorModel(
        visitorName: data['visitorName'] ?? 'unk',
        visitorPreRegis: data['visitorPreRegis'] ?? 'unk',
        visitorValidate: data['visitorValidate'] ?? 'unk',
        visitorId: data['visitorId'],
        visitorIcPassport: data['visitorIcPassport'],
        entryTime: data['entryTime'],
        expectedEntryTime: data['entryTime'],
        dateCreated: data['dateCreated']);
  }
}
