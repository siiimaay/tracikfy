import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'employee_event.dart';

part 'employee_state.dart';

part 'employee_bloc.freezed.dart';

@Injectable()
class EmployeeBloc extends Bloc<EmployeeDetailEvent, EmployeeDetailState> {
  EmployeeBloc() : super(EmployeeDetailState.initial()) {
    on<EmployeeDetailEvent>((event, emit) {
      event.map(save: (event) {
        emit(state.copyWith(isLoading: true));

      });
    });
  }
}
