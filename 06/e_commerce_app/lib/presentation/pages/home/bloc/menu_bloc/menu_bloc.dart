import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../data/data_source/mock/display/menu/menu.model.dart';
import '../../../../../domain/model/common/result.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../domain/usecase/display/menu/get_menus.usecase.dart';

part 'menu_event.dart';

part 'menu_state.dart';

part 'menu_bloc.freezed.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final DisplayUsecase _displayUsecase;

  MenuBloc(this._displayUsecase) : super(MenuState());

  Future<void> _onMenuInitialized(
      MenuInitialized event, Emitter<MenuState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {} catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
          status: Status.error, error: CommonException.setError(error)));
    }
  }

  Future<Result<List<Menu>>> _fetch(MallType mallType) async {
    return await _displayUsecase.excute(
      usecase: GetMenusUsecase(mallType: mallType),
    );
  }
}
