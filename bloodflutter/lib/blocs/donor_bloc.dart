import 'dart:async';
import 'package:bloodflutter/services/blood_bank_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'donor_event.dart';
part 'donor_state.dart';

class DonorBloc extends Bloc<DonorEvent, DonorState> {
  final BloodBankService _service;

  DonorBloc(this._service) : super(DonorInitial()) {
    on<UploadDonors>(_handleUploadDonors);
    on<LoadStats>(_handleLoadStats);
  }

  FutureOr<void> _handleUploadDonors(
    UploadDonors event,
    Emitter<DonorState> emit,
  ) async {
    try {
      emit(DonorLoading());
      await _service.uploadDonors(event.filePath);
      emit(DonorUploadSuccess());
    } catch (e) {
      emit(DonorError(e.toString()));
    }
  }

  FutureOr<void> _handleLoadStats(
    LoadStats event,
    Emitter<DonorState> emit,
  ) async {
    try {
      emit(DonorLoading());
      final stats = await _service.getStats();
      emit(DonorStatsLoaded(stats));
    } catch (e) {
      emit(DonorError(e.toString()));
    }
  }
}