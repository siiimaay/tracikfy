
import '../../../../core/injection/locator.dart';
import '../../domain/company_storage_service.dart';
import '../company.dart';

class CompanyRepository {
  static CompanyRepository? _instance;
  late final CompanyStorageService _companyStorageService;

  CompanyRepository._() {
    _companyStorageService = getIt<CompanyStorageService>();
  }

  factory CompanyRepository() {
    return _instance ??= CompanyRepository._();
  }

  Future<List<Company>> fetchCompanies() async {
    return _companyStorageService.fetchRecords();
  }

  Future<void> deleteCompany(String id) async {
    await _companyStorageService.deleteRecord(id: id);
  }

  Future<void> saveCompany(
      String name, String duration, List<String> laps) async {
    await _companyStorageService.saveRecord(
      name: name,
      duration: duration,
      laps: laps,
    );
  }
}
