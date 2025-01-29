part of 'donor_bloc.dart';

abstract class DonorState {}

class DonorInitial extends DonorState {}

class DonorLoading extends DonorState {}

class DonorUploadSuccess extends DonorState {}

class DonorDataAvailable extends DonorState {} 

class DonorStatsLoaded extends DonorState {
  final Map<String, dynamic> stats;
  DonorStatsLoaded(this.stats);
}

class DonorError extends DonorState {
  final String message;
  DonorError(this.message);
}