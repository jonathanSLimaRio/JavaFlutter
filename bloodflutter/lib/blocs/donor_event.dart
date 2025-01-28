part of 'donor_bloc.dart';

abstract class DonorEvent {}

class UploadDonors extends DonorEvent {
  final String filePath;
  UploadDonors(this.filePath);
}

class LoadStats extends DonorEvent {}