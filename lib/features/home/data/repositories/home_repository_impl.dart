import 'package:dartz/dartz.dart';
import 'package:tap_invest/core/failures/failures.dart';
import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_datasource.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_repository.dart';

class HomeRepositoryImpl implements AbstractHomeRepository {
  final AbstractHomeDatasource homeDatasource;

  HomeRepositoryImpl({required this.homeDatasource});
  @override
  Future<Either<Failures, CompanyDetailsResponseModel>>
  fetchCompanyDetails() async {
    try {
      final result = await homeDatasource.fetchCompanyDetails();
      return Right(result);
    } catch (e) {
      return Left(
        NetworkFailure(message: 'Failed to fetch company details: $e'),
      );
    }
  }

  @override
  Future<Either<Failures, CompanyListResponseModel>> fetchCompanyList() async {
    try {
      final result = await homeDatasource.fetchCompanyList();
      return Right(result);
    } catch (e) {
      return Left(
        NetworkFailure(message: 'Failed to fetch company details: $e'),
      );
    }
  }
}
