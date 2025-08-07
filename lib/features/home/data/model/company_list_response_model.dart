import 'package:equatable/equatable.dart';

class CompanyListResponseModel extends Equatable {
  const CompanyListResponseModel({required this.data});

  final List<Company> data;

  CompanyListResponseModel copyWith({List<Company>? data}) {
    return CompanyListResponseModel(data: data ?? this.data);
  }

  factory CompanyListResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyListResponseModel(
      data: json["data"] == null
          ? []
          : List<Company>.from(json["data"]!.map((x) => Company.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [data];
}

class Company extends Equatable {
  const Company({
    required this.logo,
    required this.isin,
    required this.rating,
    required this.companyName,
    required this.tags,
  });

  final String? logo;
  final String? isin;
  final String? rating;
  final String? companyName;
  final List<String> tags;

  Company copyWith({
    String? logo,
    String? isin,
    String? rating,
    String? companyName,
    List<String>? tags,
  }) {
    return Company(
      logo: logo ?? this.logo,
      isin: isin ?? this.isin,
      rating: rating ?? this.rating,
      companyName: companyName ?? this.companyName,
      tags: tags ?? this.tags,
    );
  }

  List<String> get searchableFields {
    return [isin ?? '', rating ?? '', companyName ?? '', ...tags];
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      logo: json["logo"],
      isin: json["isin"],
      rating: json["rating"],
      companyName: json["company_name"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "logo": logo,
    "isin": isin,
    "rating": rating,
    "company_name": companyName,
    "tags": tags.map((x) => x).toList(),
  };

  @override
  List<Object?> get props => [logo, isin, rating, companyName, tags];
}
