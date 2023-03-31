class PickedTaskModel {
  int? id;
  int? taskId;
  int? userId;
  bool? uploadedEvidence;
  bool? approvedByAgent;
  bool? approvedByVendor;
  bool? approved;
  String? approvedBy;
  String? approvedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<SubmittedEvidences>? submittedEvidences;

  PickedTaskModel(
      {this.id,
      this.taskId,
      this.userId,
      this.uploadedEvidence,
      this.approvedByAgent,
      this.approvedByVendor,
      this.approved,
      this.approvedBy,
      this.approvedAt,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.submittedEvidences});

  PickedTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['TaskId'];
    userId = json['UserId'];
    uploadedEvidence = json['uploaded_evidence'];
    approvedByAgent = json['approved_by_agent'];
    approvedByVendor = json['approved_by_vendor'];
    approved = json['approved'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['SubmittedEvidences'] != null) {
      submittedEvidences = <SubmittedEvidences>[];
      json['SubmittedEvidences'].forEach((v) {
        submittedEvidences?.add(new SubmittedEvidences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TaskId'] = this.taskId;
    data['UserId'] = this.userId;
    data['uploaded_evidence'] = this.uploadedEvidence;
    data['approved_by_agent'] = this.approvedByAgent;
    data['approved_by_vendor'] = this.approvedByVendor;
    data['approved'] = this.approved;
    data['approved_by'] = this.approvedBy;
    data['approved_at'] = this.approvedAt;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.submittedEvidences != null) {
      data['SubmittedEvidences'] =
          this.submittedEvidences?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubmittedEvidences {
  int? id;
  int? taskAssignmentId;
  String? comment;
  List<String>? uploads;
  String? type;
  String? source;
  String? createdAt;
  String? updatedAt;

  SubmittedEvidences(
      {this.id,
      this.taskAssignmentId,
      this.comment,
      this.uploads,
      this.type,
      this.source,
      this.createdAt,
      this.updatedAt});

  SubmittedEvidences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskAssignmentId = json['TaskAssignmentId'];
    comment = json['comment'];
    uploads = json['uploads'].cast<String>();
    type = json['type'];
    source = json['source'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['TaskAssignmentId'] = this.taskAssignmentId;
    data['comment'] = this.comment;
    data['uploads'] = this.uploads;
    data['type'] = this.type;
    data['source'] = this.source;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
