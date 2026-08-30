import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:ayez_ahlaq/generated/l10n.dart';
import '../../error/failure.dart';
import '../../helpers/safe_print.dart';
import '../constants/http_codes.dart';
import '../constants/http_headers.dart';
import '../utils/connection_checker.dart';
import '../utils/signature_generator.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio);

  Future<Either<Failure, dynamic>> _safeRequest(
    Future<Response> Function() request,
  ) async {
    if (!await ConnectionChecker.hasInternet()) {
      return Left(Failure(S().noInternet, null, {}));
    }

    try {
      final response = await request();

      if (HttpCodes.isSuccess(response.statusCode)) {
        final data = response.data;

        if (data is Map && data['status'] == false) {
          final message = _extractMessage(data);
          safePrint('API logical error => $message');
          return Left(
            Failure(
              message,
              response.statusCode,
              data['data'] is Map<String, dynamic>
                  ? data['data'] as Map<String, dynamic>
                  : {},
            ),
          );
        }

        return Right(data);
      }

      return Left(
        Failure(
          _extractMessage(response.data),
          response.statusCode,
          response.data is Map ? response.data['data'] ?? {} : {},
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      safePrint(e.toString());
      return Left(Failure(S().somethingWentWrong, null, {}));
    }
  }

  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) {
    return _safeRequest(
      () => dio.get(endPoint, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> postData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isRaw = true,
  }) {
    final payload = _preparePayload(data, isRaw);
    return _safeRequest(
      () => dio.post(endPoint, data: payload, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> putData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isRaw = true,
  }) {
    final payload = _preparePayload(data, isRaw);
    return _safeRequest(
      () => dio.put(endPoint, data: payload, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _safeRequest(
      () => dio.delete(endPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> postEncryptedData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) {
    final payload = jsonEncode(data ?? {});

    dio.options.headers[HttpHeadersKeys.signature] =
        SignatureGenerator.generate(payload);

    return postData(
      endPoint: endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Either<Failure, dynamic>> uploadFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
  }) {
    return _safeRequest(
      () => dio.post(
        endPoint,
        data: formData,
        queryParameters: queryParameters,
        options: Options(contentType: Headers.multipartFormDataContentType),
      ),
    );
  }

  Future<Either<Failure, dynamic>> patchFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
  }) {
    return _safeRequest(
      () => dio.patch(
        endPoint,
        data: formData,
        queryParameters: queryParameters,
        options: Options(contentType: Headers.multipartFormDataContentType),
      ),
    );
  }

  Future<Either<Failure, dynamic>> getImageData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await ConnectionChecker.hasInternet()) {
      return Left(Failure(S().noInternet, 400, {}));
    }

    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.bytes),
      );

      if (HttpCodes.isSuccess(response.statusCode)) {
        return Right(response.data);
      }

      return Left(_extractFailureFromBytes(response.data));
    } on DioException catch (e) {
      return Left(_extractFailureFromBytes(e.response?.data));
    } catch (_) {
      return Left(Failure(S().somethingWentWrong, 400, {}));
    }
  }

  dynamic _preparePayload(dynamic data, bool isRaw) {
    if (data == null) return null;
    if (isRaw) return data;
    if (data is Map<String, dynamic>) return FormData.fromMap(data);
    return data;
  }

  Failure _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.response == null) {
      return Failure(S().noInternet, e.response?.statusCode, {});
    }

    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      return Failure(
        _extractMessage(data),
        e.response?.statusCode,
        data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : {},
      );
    }

    return Failure(S().somethingWentWrong, e.response?.statusCode, {});
  }

  String _extractMessage(dynamic data) {
    if (data is Map) {
      return data['detail'] ??
          data['message'] ??
          data['msg'] ??
          data['error'] ??
          data['errorMessage'] ??
          S().somethingWentWrong;
    }
    return S().somethingWentWrong;
  }

  Failure _extractFailureFromBytes(dynamic data) {
    try {
      if (data is List<int>) {
        final decoded = jsonDecode(utf8.decode(data));
        return Failure(
          _extractMessage(decoded),
          400,
          decoded is Map ? decoded['data'] ?? {} : {},
        );
      }

      if (data is Map) {
        return Failure(_extractMessage(data), 400, data['data'] ?? {});
      }
    } catch (_) {}

    return Failure(S().somethingWentWrong, 400, {});
  }
}
