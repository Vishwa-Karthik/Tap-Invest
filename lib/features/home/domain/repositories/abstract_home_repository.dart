import 'package:dartz/dartz.dart';
import 'package:tap_invest/core/failures/failures.dart';
import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';

abstract class AbstractHomeRepository {
  Future<Either<Failures, CompanyListResponseModel>> fetchCompanyList();
  Future<Either<Failures, CompanyDetailsResponseModel>> fetchCompanyDetails();
}
