
class UserModel {
  // Step 1: Create Account
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? referralCode;

  // Step 2: Personal Information
  final String? cnic;
  final String? dob;
  final String? gender;
  final String? fatherOrHusbandName;

  // Step 3: Address Details
  final String? province;
  final String? city;
  final String? residentialAddress;
  final String? postalCode;

  // Step 4: Employment & Income
  final String? occupation;
  final String? employmentType;
  final String? employerName;
  final String? monthlyIncomeRange;
  final String? incomeSource;
  final String? ntn;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.referralCode,
    this.cnic,
    this.dob,
    this.gender,
    this.fatherOrHusbandName,
    this.province,
    this.city,
    this.residentialAddress,
    this.postalCode,
    this.occupation,
    this.employmentType,
    this.employerName,
    this.monthlyIncomeRange,
    this.incomeSource,
    this.ntn,
  });

  String get fullName => "$firstName $lastName";

  /// Returns a copy of this model with the given fields replaced.
  /// Every step only needs to pass the handful of fields it collected.
  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? referralCode,
    String? cnic,
    String? dob,
    String? gender,
    String? fatherOrHusbandName,
    String? province,
    String? city,
    String? residentialAddress,
    String? postalCode,
    String? occupation,
    String? employmentType,
    String? employerName,
    String? monthlyIncomeRange,
    String? incomeSource,
    String? ntn,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      referralCode: referralCode ?? this.referralCode,
      cnic: cnic ?? this.cnic,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      fatherOrHusbandName: fatherOrHusbandName ?? this.fatherOrHusbandName,
      province: province ?? this.province,
      city: city ?? this.city,
      residentialAddress: residentialAddress ?? this.residentialAddress,
      postalCode: postalCode ?? this.postalCode,
      occupation: occupation ?? this.occupation,
      employmentType: employmentType ?? this.employmentType,
      employerName: employerName ?? this.employerName,
      monthlyIncomeRange: monthlyIncomeRange ?? this.monthlyIncomeRange,
      incomeSource: incomeSource ?? this.incomeSource,
      ntn: ntn ?? this.ntn,
    );
  }

  @override
  String toString() => 'UserModel(${toMap()})';

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'referralCode': referralCode,
      'cnic': cnic,
      'dob': dob,
      'gender': gender,
      'fatherOrHusbandName': fatherOrHusbandName,
      'province': province,
      'city': city,
      'residentialAddress': residentialAddress,
      'postalCode': postalCode,
      'occupation': occupation,
      'employmentType': employmentType,
      'employerName': employerName,
      'monthlyIncomeRange': monthlyIncomeRange,
      'incomeSource': incomeSource,
      'ntn': ntn,
    };
  }
}