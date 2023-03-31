class TaskModel {
  int? id;
  int? campaignId;
  String? name;
  String? description;
  int? amount;
  bool? isCompleted;
  int? assignmentCount;
  int? assigned;
  bool? requireVendorApproval;
  bool? requireAgentApproval;
  bool? requireEvidence;
  String? createdAt;
  String? updatedAt;

  TaskModel(
      {this.id,
      this.campaignId,
      this.name,
      this.description,
      this.amount,
      this.isCompleted,
      this.assignmentCount,
      this.assigned,
      this.requireVendorApproval,
      this.requireAgentApproval,
      this.requireEvidence,
      this.createdAt,
      this.updatedAt});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignId = json['CampaignId'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    isCompleted = json['isCompleted'];
    assignmentCount = json['assignment_count'];
    assigned = json['assigned'];
    requireVendorApproval = json['require_vendor_approval'];
    requireAgentApproval = json['require_agent_approval'];
    requireEvidence = json['require_evidence'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CampaignId'] = this.campaignId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['isCompleted'] = this.isCompleted;
    data['assignment_count'] = this.assignmentCount;
    data['assigned'] = this.assigned;
    data['require_vendor_approval'] = this.requireVendorApproval;
    data['require_agent_approval'] = this.requireAgentApproval;
    data['require_evidence'] = this.requireEvidence;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
