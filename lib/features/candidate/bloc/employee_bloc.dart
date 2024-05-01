import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:trackify/features/candidate/data/employee_repository.dart';
import 'package:trackify/features/company/data/repository/company_repository.dart';

import '../../../core/injection/locator.dart';
import '../../company/data/company.dart';

part 'employee_event.dart';

part 'employee_state.dart';

part 'employee_bloc.freezed.dart';

@Injectable()
class EmployeeBloc extends Bloc<EmployeeDetailEvent, EmployeeDetailState> {
  EmployeeBloc() : super(EmployeeDetailState.initial()) {
    on<EmployeeDetailEvent>((event, emit) async {
      await event.map(
        save: (event) async {
          emit(state.copyWith(isLoading: true));
          try {
            await getIt
                .get<EmployeeRepository>()
                .saveEmployee(employee: event.data)
                .then((_) {
              emit(state.copyWith(isLoading: false));
            });
          } catch (e) {
            // Handle any errors here
            emit(state.copyWith(isLoading: false));
          }
        },
        fetchCompanies: (value) async {
          emit(state.copyWith(isLoading: true));
          try {
            await getIt.get<CompanyRepository>().fetchCompanies().then(
                (value) => emit(state.copyWith(
                    companies: value as List<Company>, isLoading: false)));
          } catch (e) {
            print(e);
            // Handle any errors here
            emit(state.copyWith(isLoading: false));
          }
        },
        selectCompany: (event) {
          emit(state.copyWith(selectedCompany: event.company));
        },
        selectDepartment: (event) {
          emit(state.copyWith(selectedDepartment: event.department));
        }, selectStatus: (event) {
          emit(state.copyWith(employeeStatus: event.status));
      },
      );
    });
  }
}
