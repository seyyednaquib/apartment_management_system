class WorkPermitModel {
  final String applyId;
  final String commencementDate;
  final String companyName;
  final String completionDate;
  final String dateCrated;
  final String work;
  final String numberOfcontractors;
  final String pdfPath;
  final String picNRIC;
  final String picName;
  final String picphoneNo;
  final String residentId;
  final String status;

  WorkPermitModel({
    required this.applyId,
    required this.commencementDate,
    required this.companyName,
    required this.completionDate,
    required this.dateCrated,
    required this.numberOfcontractors,
    required this.picNRIC,
    required this.pdfPath,
    required this.work,
    required this.picName,
    required this.picphoneNo,
    required this.residentId,
    required this.status,
  });

  factory WorkPermitModel.fromRTDB(Map<String, dynamic> data) {
    return WorkPermitModel(
        completionDate: data['completionDate'] ?? 'unk',
        dateCrated: data['dateCrated'] ?? 'unk',
        numberOfcontractors: data['numberOfcontractors'] ?? 'unk',
        pdfPath: data['pdfPath'] ?? 'unk',
        applyId: data['applyId'],
        companyName: data['companyName'],
        commencementDate: data['commencementDate'],
        picNRIC: data['picNRIC'],
        picName: data['picName'],
        picphoneNo: data['picphoneNo'],
        residentId: data['residentId'],
        status: data['status'],
        work: data['work']);
  }
}
