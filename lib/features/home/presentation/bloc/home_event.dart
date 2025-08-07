part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeCompanyList extends HomeEvent {
  const HomeCompanyList();

  @override
  List<Object> get props => [];
}

class HomeSearchCompany extends HomeEvent {
  final String query;

  const HomeSearchCompany(this.query);

  @override
  List<Object> get props => [query];
}

class HomeCompanyDetails extends HomeEvent {
  const HomeCompanyDetails();

  @override
  List<Object> get props => [];
}
