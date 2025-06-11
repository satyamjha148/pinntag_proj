class LoginResponseModel {
  final String? message;
  final bool? status;
  final String? token;
  final bool? fcmExists;
  final User? user;

  LoginResponseModel({
    this.message,
    this.status,
    this.token,
    this.fcmExists,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      status: json['status'],
      token: json['token'],
      fcmExists: json['fcmExists'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final String? id;
  final bool? isDeleted;
  final bool? isBlocked;
  final List<Role>? role;
  final int? status;
  final bool? isActive;
  final String? creatorType;
  final String? profilePhoto;
  final String? name;
  final String? email;
  final bool? isEmailVerified;
  final bool? forcePasswordReset;
  final List<String>? assignedOutlets;
  final double? scalabilityFactor;
  final String? drive;
  final String? selectedBusiness;
  final List<Business>? business;

  User({
    this.id,
    this.isDeleted,
    this.isBlocked,
    this.role,
    this.status,
    this.isActive,
    this.creatorType,
    this.profilePhoto,
    this.name,
    this.email,
    this.isEmailVerified,
    this.forcePasswordReset,
    this.assignedOutlets,
    this.scalabilityFactor,
    this.drive,
    this.selectedBusiness,
    this.business,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      isDeleted: json['isDeleted'],
      isBlocked: json['isBlocked'],
      role:
          (json['role'] as List<dynamic>?)
              ?.map((e) => Role.fromJson(e))
              .toList(),
      status: json['status'],
      isActive: json['isActive'],
      creatorType: json['creatorType'],
      profilePhoto: json['profilePhoto'],
      name: json['name'],
      email: json['email'],
      isEmailVerified: json['isEmailVerified'],
      forcePasswordReset: json['forcePasswordReset'],
      assignedOutlets:
          (json['assignedOutlets'] as List<dynamic>?)?.cast<String>(),
      scalabilityFactor: (json['scalabilityFactor'] as num?)?.toDouble(),
      drive: json['drive'],
      selectedBusiness: json['selectedBusiness'],
      business:
          (json['business'] as List<dynamic>?)
              ?.map((e) => Business.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'isDeleted': isDeleted,
      'isBlocked': isBlocked,
      'role': role?.map((r) => r.toJson()).toList(),
      'status': status,
      'isActive': isActive,
      'creatorType': creatorType,
      'profilePhoto': profilePhoto,
      'name': name,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'forcePasswordReset': forcePasswordReset,
      'assignedOutlets': assignedOutlets,
      'scalabilityFactor': scalabilityFactor,
      'drive': drive,
      'selectedBusiness': selectedBusiness,
      'business': business?.map((b) => b.toJson()).toList(),
    };
  }
}

class Role {
  final String? id;
  final String? name;
  final String? description;

  Role({this.id, this.name, this.description});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'description': description};
  }
}

class Business {
  final String? id;
  final int? status;
  final bool? isDeleted;
  final bool? isFromCrawler;
  final String? logo;
  final List<String>? businessCategories;
  final BusinessIndustry? businessIndustry;
  final String? cover;
  final String? authorisedUser;
  final List<Outlet>? outlets;
  final String? countryCode;
  final String? phone;
  final String? email;
  final String? website;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final bool? isActive;
  final String? postalCode;
  final int? followersCount;
  final int? followingCount;
  final String? name;

  Business({
    this.id,
    this.status,
    this.isDeleted,
    this.isFromCrawler,
    this.logo,
    this.businessCategories,
    this.businessIndustry,
    this.cover,
    this.authorisedUser,
    this.outlets,
    this.countryCode,
    this.phone,
    this.email,
    this.website,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.isActive,
    this.postalCode,
    this.followersCount,
    this.followingCount,
    this.name,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      status: json['status'],
      isDeleted: json['isDeleted'],
      isFromCrawler: json['isFromCrawler'],
      logo: json['logo'],
      businessCategories:
          (json['businessCategories'] as List<dynamic>?)?.cast<String>(),
      businessIndustry:
          json['businessIndustry'] != null
              ? BusinessIndustry.fromJson(json['businessIndustry'])
              : null,
      cover: json['cover'],
      authorisedUser: json['authorisedUser'],
      outlets:
          (json['outlets'] as List<dynamic>?)
              ?.map((e) => Outlet.fromJson(e))
              .toList(),
      countryCode: json['countryCode'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      isActive: json['isActive'],
      postalCode: json['postalCode'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'status': status,
      'isDeleted': isDeleted,
      'isFromCrawler': isFromCrawler,
      'logo': logo,
      'businessCategories': businessCategories,
      'businessIndustry': businessIndustry?.toJson(),
      'cover': cover,
      'authorisedUser': authorisedUser,
      'outlets': outlets?.map((o) => o.toJson()).toList(),
      'countryCode': countryCode,
      'phone': phone,
      'email': email,
      'website': website,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'isActive': isActive,
      'postalCode': postalCode,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'name': name,
    };
  }
}

class BusinessIndustry {
  final String? id;
  final String? title;
  final String? darkIcon;
  final String? lightIcon;

  BusinessIndustry({this.id, this.title, this.darkIcon, this.lightIcon});

  factory BusinessIndustry.fromJson(Map<String, dynamic> json) {
    return BusinessIndustry(
      id: json['_id'],
      title: json['title'],
      darkIcon: json['darkIcon'],
      lightIcon: json['lightIcon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'darkIcon': darkIcon,
      'lightIcon': lightIcon,
    };
  }
}

class Outlet {
  final String? id;
  final String? name;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? phone;
  final String? email;
  final String? website;
  final double? latitude;
  final double? longitude;

  Outlet({
    this.id,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.phone,
    this.email,
    this.website,
    this.latitude,
    this.longitude,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      id: json['_id'],
      name: json['name'],
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      state: json['state'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'phone': phone,
      'email': email,
      'website': website,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
