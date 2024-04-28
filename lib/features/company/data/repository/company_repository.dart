import 'package:get_it/get_it.dart';
import 'package:trackify/core/service/firestore_service.dart';
import 'package:trackify/features/company/domain/comp_storage_service.dart';

import '../../../../core/injection/locator.dart';
import '../company.dart';

class CompanyRepository {
  static CompanyRepository? _instance;
  late final FirestoreService _companyStorageService;

  CompanyRepository._() {
   _companyStorageService =getIt.get(instanceName: "company_firestore");
  }

  factory CompanyRepository() {
    return _instance ??= CompanyRepository._();
  }

  Future<List> fetchCompanies() async {
// return _companyStorageService.fetchRecords();
  return [];
  }

  Future<void> deleteCompany(String id) async {
    //  await _companyStorageService.deleteRecord(id: id);
  }

  Future<void> saveCompany({
    required Company company,
  }) async {
    await _companyStorageService.saveRecord(data: company);
  }
}
