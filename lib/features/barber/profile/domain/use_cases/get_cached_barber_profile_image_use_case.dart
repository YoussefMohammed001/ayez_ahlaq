import 'dart:typed_data';
import '../repos/i_barber_profile_repo.dart';

class GetCachedBarberProfileImageUseCase {
  final IBarberProfileRepo _repo;

  GetCachedBarberProfileImageUseCase(this._repo);

  Future<Uint8List?> call() => _repo.getCachedProfileImage();
}
