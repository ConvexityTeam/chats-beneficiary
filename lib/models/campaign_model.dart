class Campaign {
  int? id;
  int? organisationId;
  String? title;
  String? type;
  String? spending;
  String? description;
  String? status;
  bool? isFunded;
  String? fundedWith;
  double? budget;
  String? location;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  Organisation? organisation;

  Campaign(
      {this.id,
      this.organisationId,
      this.title,
      this.type,
      this.spending,
      this.description,
      this.status,
      this.isFunded,
      this.fundedWith,
      this.budget,
      this.location,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.organisation});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organisationId = json['OrganisationId'];
    title = json['title'];
    type = json['type'];
    spending = json['spending'];
    description = json['description'];
    status = json['status'];
    isFunded = json['is_funded'];
    fundedWith = json['funded_with'];
    budget = json['budget']?.toDouble();
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    organisation = json['Organisation'] != null
        ? new Organisation.fromJson(json['Organisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['OrganisationId'] = this.organisationId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['spending'] = this.spending;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_funded'] = this.isFunded;
    data['funded_with'] = this.fundedWith;
    data['budget'] = this.budget;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.organisation != null) {
      data['Organisation'] = this.organisation!.toJson();
    }
    return data;
  }
}

class Organisation {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? state;
  String? country;
  String? logoLink;
  String? websiteUrl;
  String? registrationId;
  bool? isVerified;
  String? yearOfInception;
  String? verificationMode;
  String? createdAt;
  String? updatedAt;

  Organisation(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.state,
      this.country,
      this.logoLink,
      this.websiteUrl,
      this.registrationId,
      this.isVerified,
      this.yearOfInception,
      this.verificationMode,
      this.createdAt,
      this.updatedAt});

  Organisation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    logoLink = json['logo_link'];
    websiteUrl = json['website_url'];
    registrationId = json['registration_id'];
    isVerified = json['is_verified'];
    yearOfInception = json['year_of_inception'];
    verificationMode = json['verificationMode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['state'] = this.state;
    data['country'] = this.country;
    data['logo_link'] = this.logoLink;
    data['website_url'] = this.websiteUrl;
    data['registration_id'] = this.registrationId;
    data['is_verified'] = this.isVerified;
    data['year_of_inception'] = this.yearOfInception;
    data['verificationMode'] = this.verificationMode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
