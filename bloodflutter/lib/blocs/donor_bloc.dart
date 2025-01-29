import 'dart:async';
import 'package:bloodflutter/services/blood_bank_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'donor_event.dart';
part 'donor_state.dart';

class DonorBloc extends Bloc<DonorEvent, DonorState> {
  final BloodBankService _service;

  DonorBloc(this._service) : super(DonorInitial()) {
    on<UploadDonors>(_handleUploadDonors);
    on<UploadLocalDonors>(_handleUploadLocalDonors);
    on<LoadStats>(_handleLoadStats);
  }

  FutureOr<void> _handleUploadDonors(
    UploadDonors event,
    Emitter<DonorState> emit,
  ) async {
    try {
      emit(DonorLoading());
      await _service.uploadDonors(event.filePath);
      emit(DonorUploadSuccess()); // Mantido para feedback imediato
      emit(DonorDataAvailable()); // Novo estado para indicar dados disponíveis
    } catch (e) {
      emit(DonorError(e.toString()));
    }
  }

  FutureOr<void> _handleUploadLocalDonors(
    UploadLocalDonors event,
    Emitter<DonorState> emit,
  ) async {
    try {
      emit(DonorLoading());
      await _service.uploadLocalDonors();
      emit(DonorUploadSuccess()); // Mantido para feedback imediato
      emit(DonorDataAvailable()); // Novo estado para indicar dados disponíveis
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
      if (stats.values.any((data) => data is Map && data.isNotEmpty)) {
        emit(DonorStatsLoaded(stats));
      } else {
        emit(DonorError('Não há dados suficientes para gerar estatísticas'));
      }
    } catch (e) {
      emit(DonorError(e.toString()));
    }
  }
}
