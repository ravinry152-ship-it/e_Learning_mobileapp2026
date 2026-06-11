import 'package:dio/dio.dart';
import 'package:e_learning_mobile/app/data/config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

class ApiProvider extends GetxService {
  late Dio _dio;
  final _box = GetStorage();

  // ─── Helper: ពិនិត្យ Token ───────────────────────────────
  bool _isValidToken(String? token) =>
      token != null &&
      token.trim().isNotEmpty &&
      token != "null" &&
      token != "undefined";

  // ─── Helper: ទាញ Token ពី Storage ───────────────────────
  String? get _accessToken => _box.read<String>('access_token');
  String? get _refreshToken => _box.read<String>('refresh_token');

  // ─── Init ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _initDio();
  }

  void _initDio() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));

    // បើ Debug mode → បង្ហាញ Log
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  // ─── Interceptor: Request ─────────────────────────────────
  // ហៅរាល់ពេល Request ចេញទៅ Server
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isValidToken(_accessToken)) {
      options.headers['Authorization'] = 'Bearer $_accessToken';
      debugPrint(" Token ញាត់ចូល: ${options.path}");
    } else {
      debugPrint(" Guest Request: ${options.path}");
    }
    handler.next(options);
  }

  // ─── Interceptor: Response ────────────────────────────────
  // ហៅរាល់ពេល Response ត្រឡប់មក — log ស្ថានភាព
  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(" Response [${response.statusCode}]: ${response.requestOptions.path}");
    handler.next(response);
  }

  // ─── Interceptor: Error ───────────────────────────────────
  // ហៅពេល Server ឆ្លើយ Error (4xx, 5xx)
  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint(" Error [${error.response?.statusCode}]: ${error.requestOptions.path}");

    // ─── Handle 401: Token ផុតកំណត់ ──────────────────────
    if (error.response?.statusCode == 401 && _isValidToken(_refreshToken)) {
      try {
        debugPrint("កំពុង Refresh Token...");

        //  ប្រើ Dio ថ្មីដាច់ដោយឡែក ដើម្បីជៀសវាង interceptor loop
        final refreshDio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
        final refreshResponse = await refreshDio.post(
          '/token/refresh/',
          data: {'refresh': _refreshToken},
        );

        if (refreshResponse.statusCode == 200) {
          // រក្សាទុក Token ថ្មី
          final newAccessToken = refreshResponse.data['access'] as String;
          final newRefreshToken = refreshResponse.data['refresh'] as String?;

          await _box.write('access_token', newAccessToken);
          if (newRefreshToken != null) {
            await _box.write('refresh_token', newRefreshToken);
          }

          debugPrint(" Refresh Token បានជោគជ័យ! កំពុង Retry Request...");

          // Retry Request ដើម ដោយ Token ថ្មី
          error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          final retryResponse = await _dio.fetch(error.requestOptions);
          return handler.resolve(retryResponse);
        }
      } on DioException catch (e) {
        // Refresh Token បរាជ័យ → Logout
        debugPrint(" Refresh Token បរាជ័យ: ${e.message}");
        await _clearSession();
        Get.offAllNamed('/login'); // ប្រគល់ User ទៅ Login
      }
    }

    handler.next(error);
  }

  // ─── Clear Session ────────────────────────────────────────
  Future<void> _clearSession() async {
    await _box.remove('access_token');
    await _box.remove('refresh_token');
    debugPrint(" Session បានលុបចោល");
  }

  // ═══════════════════════════════════════════════════════════
  // HTTP Methods
  // ═══════════════════════════════════════════════════════════

  /// GET request
  /// [path] — endpoint ឧទាហរណ៍ '/courses/'
  /// [query] — query parameters ឧទាហរណ៍ {'page': 1}
  Future<Response> get(
    String path, {
    Map<String, dynamic>? query, Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: query);
    } on DioException {
      rethrow;
    }
  }

  /// POST request
  /// [data] — request body
  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException {
      rethrow;
    }
  }

  /// PUT request — Update ទិន្នន័យទាំងមូល
  Future<Response> put(
    String path, {
    dynamic data,
  }) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException {
      rethrow;
    }
  }

  /// PATCH request — Update ទិន្នន័យមួយផ្នែក
  Future<Response> patch(
    String path, {
    dynamic data,
  }) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException {
      rethrow;
    }
  }
}