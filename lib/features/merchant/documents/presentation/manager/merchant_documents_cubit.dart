import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/merchant_document.dart';
import '../../domain/use_cases/delete_document_file_use_case.dart';
import '../../domain/use_cases/download_document_file_use_case.dart';
import '../../domain/use_cases/get_documents_use_case.dart';
import '../../domain/use_cases/upload_document_file_use_case.dart';
import 'merchant_documents_state.dart';

class MerchantDocumentsCubit extends Cubit<MerchantDocumentsState> {
  final GetDocumentsUseCase _getDocuments;
  final UploadDocumentFileUseCase _uploadFile;
  final DeleteDocumentFileUseCase _deleteFile;
  final DownloadDocumentFileUseCase _downloadFile;

  MerchantDocumentsCubit(
    this._getDocuments,
    this._uploadFile,
    this._deleteFile,
    this._downloadFile,
  ) : super(const MerchantDocumentsState());

  Future<Uint8List?> downloadFile(int id) async {
    emit(state.copyWith(busyIds: {...state.busyIds, id}));

    final result = await _downloadFile(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            busyIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return null;
      },
      (bytes) {
        emit(state.copyWith(busyIds: _without(id)));
        return bytes;
      },
    );
  }

  Future<void> loadDocuments() async {
    emit(state.copyWith(status: DocumentsStatus.loading));

    final result = await _getDocuments();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DocumentsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (documents) => emit(
        state.copyWith(
          status: DocumentsStatus.success,
          documents: documents,
        ),
      ),
    );
  }

  Future<bool> uploadFile(int id, String filePath) async {
    emit(state.copyWith(busyIds: {...state.busyIds, id}));

    final result = await _uploadFile(id, filePath);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            busyIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (document) {
        emit(
          state.copyWith(
            busyIds: _without(id),
            documents: _replace(document),
          ),
        );
        return true;
      },
    );
  }

  Future<bool> deleteFile(int id) async {
    emit(state.copyWith(busyIds: {...state.busyIds, id}));

    final result = await _deleteFile(id);

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            busyIds: _without(id),
            errorMessage: failure.message,
          ),
        );
        return false;
      },
      (_) {
        emit(
          state.copyWith(busyIds: _without(id), documents: _clearFile(id)),
        );
        return true;
      },
    );
  }

  Set<int> _without(int id) =>
      state.busyIds.where((element) => element != id).toSet();

  List<MerchantDocument> _replace(MerchantDocument document) {
    return state.documents
        .map((d) => d.id == document.id ? document : d)
        .toList();
  }

  List<MerchantDocument> _clearFile(int id) {
    return state.documents
        .map(
          (d) => d.id != id
              ? d
              : MerchantDocument(
                  id: d.id,
                  name: d.name,
                  required: d.required,
                  hasFile: false,
                ),
        )
        .toList();
  }
}
