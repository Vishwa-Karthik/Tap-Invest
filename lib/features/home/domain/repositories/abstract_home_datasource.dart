import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';

abstract class AbstractHomeDatasource {
  Future<CompanyListResponseModel> fetchCompanyList();
  Future<CompanyDetailsResponseModel> fetchCompanyDetails();
}
