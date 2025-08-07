part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final CompanyDetailsResponseModel? companyDetails;
  final List<Company>? companyList;
  final List<Company>? originalCompanyList;
  final bool? isSearchActive;
  final HomeStatus status;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.companyDetails,
    this.originalCompanyList,
    this.companyList,
    this.isSearchActive,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    companyDetails,
    originalCompanyList,
    companyList,
    isSearchActive,
  ];

  HomeState copyWith({
    CompanyDetailsResponseModel? companyDetails,
    List<Company>? companyList,
    List<Company>? originalCompanyList,
    bool? isSearchActive,
    HomeStatus? status,
    String? errorMessage,
  }) {
    return HomeState(
      companyDetails: companyDetails ?? this.companyDetails,
      originalCompanyList: originalCompanyList ?? this.originalCompanyList,
      companyList: companyList ?? this.companyList,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
