class AppUsersModel {
  UserModel? user;

  AppUsersModel({this.user});

  AppUsersModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserModel {
  String? sId;
  int? id;
  String? createdAt;
  String? updatedAt;
  String? lastRequestAt;
  String? timezone;
  String? login;
  String? email;
  String? fullName;
  String? phone;
  String? website;
  String? twitterId;
  String? externalUserId;
  String? facebookId;
  String? customData;
  String? userTags;
  String? avatar;
  String? externalId;
  String? isGuest;

  UserModel(
      {this.sId,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.lastRequestAt,
        this.timezone,
        this.login,
        this.email,
        this.fullName,
        this.phone,
        this.website,
        this.twitterId,
        this.externalUserId,
        this.facebookId,
        this.customData,
        this.userTags,
        this.avatar,
        this.externalId,
        this.isGuest});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastRequestAt = json['last_request_at'];
    timezone = json['timezone'].toString();
    login = json['login'];
    email = json['email'];
    fullName = json['full_name'];
    phone = json['phone'];
    website = json['website'];
    twitterId = json['twitter_id'];
    externalUserId = json['external_user_id'].toString();
    facebookId = json['facebook_id'];
    customData = json['custom_data'].toString();
    userTags = json['user_tags'].toString();
    avatar = json['avatar'];
    externalId = json['external_id'];
    isGuest = json['is_guest'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_request_at'] = lastRequestAt;
    data['timezone'] = timezone;
    data['login'] = login;
    data['email'] = email;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['website'] = website;
    data['twitter_id'] = twitterId;
    data['external_user_id'] = externalUserId;
    data['facebook_id'] = facebookId;
    data['custom_data'] = customData;
    data['user_tags'] = userTags;
    data['avatar'] = avatar;
    data['external_id'] = externalId;
    data['is_guest'] = isGuest;
    return data;
  }
}