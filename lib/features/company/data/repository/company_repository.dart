import '../../../../core/injection/locator.dart';
import '../../domain/company_storage_service.dart';
import '../company.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CompanyRepository {
  static CompanyRepository? _instance;
  late final CompanyStorageService _companyStorageService;

  CompanyRepository._() {
    _companyStorageService = getIt.get<CompanyStorageService>();
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

  Future<void> saveCompany({
    required Company company,
  }) async {
    await _companyStorageService.saveRecord(data: company);
  }
}
