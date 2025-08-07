import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_datasource.dart';

class HomeDatasouceImpl implements AbstractHomeDatasource {
  @override
  Future<CompanyDetailsResponseModel> fetchCompanyDetails() async {
    try {
      final response = await http.Client().get(
        Uri.parse('https://eo61q3zd4heiwke.m.pipedream.net/'),
      );
      if (response.statusCode == 200) {
        return CompanyDetailsResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load company details');
      }
    } catch (e) {
      throw Exception('Failed to fetch company details: $e');
    }
  }

  @override
  Future<CompanyListResponseModel> fetchCompanyList() async {
    try {
      final response = await http.Client().get(
        Uri.parse('https://eol122duf9sy4de.m.pipedream.net/'),
      );
      if (response.statusCode == 200) {
        return CompanyListResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load company details');
      }
    } catch (e) {
      throw Exception('Failed to fetch company details: $e');
    }
  }
}
