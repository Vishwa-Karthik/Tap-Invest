import 'package:equatable/equatable.dart';

class CompanyDetailsResponseModel extends Equatable {
  const CompanyDetailsResponseModel({
    required this.logo,
    required this.companyName,
    required this.description,
    required this.isin,
    required this.status,
    required this.prosAndCons,
    required this.financials,
    required this.issuerDetails,
  });

  final String? logo;
  final String? companyName;
  final String? description;
  final String? isin;
  final String? status;
  final ProsAndCons? prosAndCons;
  final Financials? financials;
  final IssuerDetails? issuerDetails;

  CompanyDetailsResponseModel copyWith({
    String? logo,
    String? companyName,
    String? description,
    String? isin,
    String? status,
    ProsAndCons? prosAndCons,
    Financials? financials,
    IssuerDetails? issuerDetails,
  }) {
    return CompanyDetailsResponseModel(
      logo: logo ?? this.logo,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      isin: isin ?? this.isin,
      status: status ?? this.status,
      prosAndCons: prosAndCons ?? this.prosAndCons,
      financials: financials ?? this.financials,
      issuerDetails: issuerDetails ?? this.issuerDetails,
    );
  }

  factory CompanyDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailsResponseModel(
      logo: json["logo"],
      companyName: json["company_name"],
      description: json["description"],
      isin: json["isin"],
      status: json["status"],
      prosAndCons: json["pros_and_cons"] == null
          ? null
          : ProsAndCons.fromJson(json["pros_and_cons"]),
      financials: json["financials"] == null
          ? null
          : Financials.fromJson(json["financials"]),
      issuerDetails: json["issuer_details"] == null
          ? null
          : IssuerDetails.fromJson(json["issuer_details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "logo": logo,
    "company_name": companyName,
    "description": description,
    "isin": isin,
    "status": status,
    "pros_and_cons": prosAndCons?.toJson(),
    "financials": financials?.toJson(),
    "issuer_details": issuerDetails?.toJson(),
  };

  @override
  List<Object?> get props => [
    logo,
    companyName,
    description,
    isin,
    status,
    prosAndCons,
    financials,
    issuerDetails,
  ];
}

class Financials extends Equatable {
  const Financials({required this.ebitda, required this.revenue});

  final List<Ebitda> ebitda;
  final List<Ebitda> revenue;

  Financials copyWith({List<Ebitda>? ebitda, List<Ebitda>? revenue}) {
    return Financials(
      ebitda: ebitda ?? this.ebitda,
      revenue: revenue ?? this.revenue,
    );
  }

  factory Financials.fromJson(Map<String, dynamic> json) {
    return Financials(
      ebitda: json["ebitda"] == null
          ? []
          : List<Ebitda>.from(json["ebitda"]!.map((x) => Ebitda.fromJson(x))),
      revenue: json["revenue"] == null
          ? []
          : List<Ebitda>.from(json["revenue"]!.map((x) => Ebitda.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "ebitda": ebitda.map((x) => x.toJson()).toList(),
    "revenue": revenue.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [ebitda, revenue];
}

class Ebitda extends Equatable {
  const Ebitda({required this.month, required this.value});

  final String? month;
  final int? value;

  Ebitda copyWith({String? month, int? value}) {
    return Ebitda(month: month ?? this.month, value: value ?? this.value);
  }

  factory Ebitda.fromJson(Map<String, dynamic> json) {
    return Ebitda(month: json["month"], value: json["value"]);
  }

  Map<String, dynamic> toJson() => {"month": month, "value": value};

  @override
  List<Object?> get props => [month, value];
}

class IssuerDetails extends Equatable {
  const IssuerDetails({
    required this.issuerName,
    required this.typeOfIssuer,
    required this.sector,
    required this.industry,
    required this.issuerNature,
    required this.cin,
    required this.leadManager,
    required this.registrar,
    required this.debentureTrustee,
  });

  final String? issuerName;
  final String? typeOfIssuer;
  final String? sector;
  final String? industry;
  final String? issuerNature;
  final String? cin;
  final String? leadManager;
  final String? registrar;
  final String? debentureTrustee;

  IssuerDetails copyWith({
    String? issuerName,
    String? typeOfIssuer,
    String? sector,
    String? industry,
    String? issuerNature,
    String? cin,
    String? leadManager,
    String? registrar,
    String? debentureTrustee,
  }) {
    return IssuerDetails(
      issuerName: issuerName ?? this.issuerName,
      typeOfIssuer: typeOfIssuer ?? this.typeOfIssuer,
      sector: sector ?? this.sector,
      industry: industry ?? this.industry,
      issuerNature: issuerNature ?? this.issuerNature,
      cin: cin ?? this.cin,
      leadManager: leadManager ?? this.leadManager,
      registrar: registrar ?? this.registrar,
      debentureTrustee: debentureTrustee ?? this.debentureTrustee,
    );
  }

  factory IssuerDetails.fromJson(Map<String, dynamic> json) {
    return IssuerDetails(
      issuerName: json["issuer_name"],
      typeOfIssuer: json["type_of_issuer"],
      sector: json["sector"],
      industry: json["industry"],
      issuerNature: json["issuer_nature"],
      cin: json["cin"],
      leadManager: json["lead_manager"],
      registrar: json["registrar"],
      debentureTrustee: json["debenture_trustee"],
    );
  }

  Map<String, dynamic> toJson() => {
    "issuer_name": issuerName,
    "type_of_issuer": typeOfIssuer,
    "sector": sector,
    "industry": industry,
    "issuer_nature": issuerNature,
    "cin": cin,
    "lead_manager": leadManager,
    "registrar": registrar,
    "debenture_trustee": debentureTrustee,
  };

  @override
  List<Object?> get props => [
    issuerName,
    typeOfIssuer,
    sector,
    industry,
    issuerNature,
    cin,
    leadManager,
    registrar,
    debentureTrustee,
  ];
}

class ProsAndCons extends Equatable {
  const ProsAndCons({required this.pros, required this.cons});

  final List<String> pros;
  final List<String> cons;

  ProsAndCons copyWith({List<String>? pros, List<String>? cons}) {
    return ProsAndCons(pros: pros ?? this.pros, cons: cons ?? this.cons);
  }

  factory ProsAndCons.fromJson(Map<String, dynamic> json) {
    return ProsAndCons(
      pros: json["pros"] == null
          ? []
          : List<String>.from(json["pros"]!.map((x) => x)),
      cons: json["cons"] == null
          ? []
          : List<String>.from(json["cons"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "pros": pros.map((x) => x).toList(),
    "cons": cons.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [pros, cons];
}
