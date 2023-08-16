import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tal3thoom/config/custom_shared_prefs.dart';
import '../../../config/dio_helper/dio.dart';
import '../../widgets/alerts.dart';
import '../models/model.dart';

part 'data_access_permission_state.dart';

class DataAccessPermissionCubit extends Cubit<DataAccessPermissionState> {
  DataAccessPermissionCubit() : super(DataAccessPermissionInitial()) {
    getAccessPermission();
  }
  final userId = Prefs.getString("userId");
  final token = Prefs.getString("token");

  Future<void> getAccessPermission() async {
    emit(DataAccessPermissionLoading());
    try {
      final userId = Prefs.getString("userId");
      final res = await NetWork.get('Stages/GetPatientStagesMobile/$userId');

      if (res.data['status'] == 0 ||
          res.data['status'] == -1 ||
          res.statusCode != 200) {
        throw res.data['message'];
      }

      emit(DataAccessPermissionSuccess(
          accessPermissionModel: DataAccessPermissionModel.fromJson(res.data)));
    } on DioError catch (_) {
      emit(DataAccessPermissionError(msg: "لا يوجد اتصال بالانترنت "));
    } catch (e, es) {
      log(e.toString());
      log(es.toString());
      emit(DataAccessPermissionError(msg: e.toString()));
    }
  }

  Future<Messages?> signOut() async {
    emit(DataAccessPermissionLoading());
    try {
      final res = await NetWork.post(
        'Patients/deleteAcc',
        body: {"userId": userId,},
      );
      if (res.data['status'] == 0 || res.data['status'] == -1) {
        // throw res.data['messages']['body'];
        final _msg = Messages.fromJson(res.data['messages'][0]);
        //  throw _msg;
        print("errrrrrrrrrrro" + _msg.toString());
      }

      emit(DataAccessPermissionSuccess(accessPermissionModel: DataAccessPermissionModel.fromJson(res.data)));
      Alert.success(Messages.fromJson(res.data['messages'][0]));



      Prefs.clear();

    } catch (e, st) {
      // Alert.success(res.data['messages']['title'].toString());
      Alert.error("عفوا !حدث خطأ ما ...!",
         );

      log(e.toString());
      log(st.toString());
      emit(DataAccessPermissionError(msg: e.toString()));
    }
    return null;
  }




}
