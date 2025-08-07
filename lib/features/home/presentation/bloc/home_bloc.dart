import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final AbstractHomeRepository homeRepository;
  HomeBloc({required this.homeRepository})
    : super(HomeState(status: HomeStatus.initial)) {
    on<HomeCompanyList>(onHomeCompanyList);
    on<HomeCompanyDetails>(onHomeCompanyDetails);
    on<HomeSearchCompany>(onHomeSearchCompany);
  }

  FutureOr<void> onHomeCompanyList(
    HomeCompanyList event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeState(status: HomeStatus.loading));

      final result = await homeRepository.fetchCompanyList();
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: HomeStatus.error,
            errorMessage: 'Failed to load company list',
          ),
        ),

        (companyList) {
          emit(
            state.copyWith(
              status: HomeStatus.loaded,
              companyList: companyList.data,
              originalCompanyList: companyList.data,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Failed to load company list',
        ),
      );
    }
  }

  FutureOr<void> onHomeCompanyDetails(
    HomeCompanyDetails event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final result = await homeRepository.fetchCompanyDetails();
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: HomeStatus.error,
            errorMessage: 'Failed to load company details',
          ),
        ),
        (companyDetails) {
          emit(
            state.copyWith(
              status: HomeStatus.loaded,
              companyDetails: companyDetails,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Failed to load company details',
        ),
      );
    }
  }

  FutureOr<void> onHomeSearchCompany(
    HomeSearchCompany event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      final query = event.query;
      if (query.isEmpty) {
        emit(
          state.copyWith(
            isSearchActive: false,
            status: HomeStatus.loaded,
            companyList: state.originalCompanyList,
          ),
        );
        return;
      }

      emit(state.copyWith(isSearchActive: true, status: HomeStatus.loading));

      emit(
        state.copyWith(
          isSearchActive: true,
          status: HomeStatus.loaded,
          companyList: state.companyList?.where((company) {
            return company.searchableFields.any(
              (field) => field.toLowerCase().contains(query.toLowerCase()),
            );
          }).toList(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'Failed to search company',
        ),
      );
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final companyList = CompanyListResponseModel.fromJson(
        json['companyList'],
      );
      return HomeState(
        status: HomeStatus.loaded,
        companyList: companyList.data,
      );
    } catch (e) {
      return HomeState(
        status: HomeStatus.error,
        errorMessage: 'Failed to load data',
      );
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    if (state.status == HomeStatus.loaded) {
      return {
        'companyList': state.companyList?.map((e) => e.toJson()).toList(),
      };
    }
    return null;
  }
}
