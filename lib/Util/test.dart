// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import '../services/analytics_service.dart';
// import '../services/authentication_service.dart';
// import '../utils/constants/colors.dart';

// import '../helpers/helper.dart';
// import '../services/logger_service.dart';
// import '../services/shared_preferences.dart';
// import '../services/theme/theme.dart';
// import '../utils/constants/shared_preferences_keys.dart';
// import 'api_exceptions.dart';

// enum RequestType { get, post, delete, put }

// extension RequestTypeExtension on RequestType {
//   static RequestType fromString(String? value) {
//     switch (value?.toLowerCase()) {
//       case 'get':
//         return RequestType.get;
//       case 'post':
//         return RequestType.post;
//       case 'delete':
//         return RequestType.delete;
//       case 'put':
//         return RequestType.put;
//       default:
//         return RequestType.get;
//     }
//   }
// }

// const String baseUrlLocal = 'http://localhost:3000';
// const String baseUrlLocal = 'http://localhost:3000';
// const String baseUrlRemote = 'https://api.thelandlord.tn';
// String _lastRequestedUrl = '';

// class ApiBaseHelper extends GetxController {
//   static ApiBaseHelper get find => Get.find<ApiBaseHelper>();
//   final String baseUrl = baseUrlLocal;
//   final String baseUrl = kReleaseMode ? baseUrlRemote : baseUrlLocal;
//   bool _isLoading = false;
//   bool blockRequest = false;
//   final _defaultHeader = {
//     'Access-Control-Allow-Origin': '*', // Required for CORS support to work
//     'Access-Control-Allow-Credentials': 'true', // Required for cookies, authorization headers with HTTPS
//     'Access-Control-Allow-Headers': 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
//     'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE',
//     'Content-type': 'application/json',
//     'charset': 'UTF-8',
//   };

//   bool get isLoading => _isLoading;

//   set isLoading(bool value) {
//     _isLoading = value;
//     update();
//   }

//   String? getToken() => SharedPreferencesService.find.get(jwtKey);

//   Future<dynamic> request(RequestType requestType, String url, {Map<String, String>? headers, dynamic body, List<XFile?>? files, bool sendToken = false}) async {
//     if (url == _lastRequestedUrl) LoggerService.logger?.w('Duplicated Request $url');
//     _lastRequestedUrl = url;
//     late http.Response response;
//     isLoading = true;
//     Helper.waitAndExecute(() => SharedPreferencesService.find.isReady, () {
//       _defaultHeader.addAll({'locale': SharedPreferencesService.find.get(languageCodeKey)!});
//     });
//     String? token;
//     if (sendToken) {
//       token = getToken();
//       _defaultHeader.remove('Authorization');
//       _defaultHeader.putIfAbsent('Authorization', () => 'Bearer $token');
//     }

//     final requestUrl = Uri.parse('$baseUrl$url');

//     if (files != null && files.isNotEmpty) {
//       final keyImage = files.length > 2 ? 'gallery' : 'photo';
//       LoggerService.logger!.i('API uploadFile, url $url');
//       final imageUploadRequest = http.MultipartRequest(requestType.name.toUpperCase(), requestUrl);
//       if (sendToken) imageUploadRequest.headers['Authorization'] = 'Bearer $token';

//       for (final file in files) {
//         Uint8List fileBytes = await file!.readAsBytes();
//         String filename = file.name;

//         imageUploadRequest.files.add(http.MultipartFile.fromBytes(keyImage, fileBytes.toList(), filename: filename));
//       }
//       if (body is Map<String, dynamic>) {
//         for (final element in (body).keys) {
//           if (body[element] != null) imageUploadRequest.fields.putIfAbsent(element, () => body[element].toString());
//         }
//       } else {
//         LoggerService.logger!.w('uploadFile body is not a Map<String, dynamic>');
//       }
//       final streamedResponse = await imageUploadRequest.send();
//       final responseData = await streamedResponse.stream.asBroadcastStream().bytesToString();
//       response = http.Response(
//         responseData,
//         streamedResponse.statusCode,
//         headers: streamedResponse.headers,
//         isRedirect: streamedResponse.isRedirect,
//         persistentConnection: streamedResponse.persistentConnection,
//         reasonPhrase: streamedResponse.reasonPhrase,
//         request: streamedResponse.request,
//       );
//     } else {
//       switch (requestType) {
//         case RequestType.get:
//           LoggerService.logger!.i('API Get, url $url');
//           response = await http.get(
//             requestUrl,
//             headers: headers ?? _defaultHeader,
//           );
//           break;
//         case RequestType.post:
//           LoggerService.logger!.i('API Post, url $url');
//           response = await http.post(
//             requestUrl,
//             body: jsonEncode(body),
//             headers: headers ?? _defaultHeader,
//           );
//           break;
//         case RequestType.put:
//           LoggerService.logger!.i('API Put, url $url');
//           response = await http.put(
//             requestUrl,
//             body: jsonEncode(body),
//             headers: headers ?? _defaultHeader,
//           );
//           break;
//         case RequestType.delete:
//           LoggerService.logger!.i('API Delete, url $url');
//           response = await http.delete(requestUrl);
//           break;
//       }
//     }
//     isLoading = false;
//     return _returnResponse(response);
//   }

//   String getImageProperty(String pictureName) => '$baseUrl/public/properties/$pictureName';
//   String getHDImageProperty(String pictureName) => '$baseUrl/public/properties/hd/$pictureName';
//   String getImageLocal(String pictureName) => pictureName;
//   String getClientImage(String pictureName) => '$baseUrl/public/images/client/$pictureName';
//   String getImageProperty(String pictureName) => 'http://localhost:9090/$_baseUrl/public/properties/$pictureName';
//   String getImageLocal(String pictureName) => 'http://localhost:9090/$pictureName';

//   dynamic _returnResponse(http.Response response) async {
//     switch (response.statusCode) {
//       case 200:
//         LoggerService.logger!.i('API Return 200 OK, length: ${jsonDecode(response.body)['count']}');
//         return jsonDecode(response.body);
//       case 201:
//         return response.statusCode;
//       case 400:
//         throw BadRequestException(jsonDecode(response.body)['message']);
//       case 401:
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw UnauthorisedException(response.body.toString());
//       case 403:
//         if (response.body.contains('session_expired')) {
//           if (kDebugMode) {
//             Helper.snackBar(message: 'session_expired', title: 'login_msg', includeDismiss: false, styleMessage: AppFonts.x12Regular.copyWith(color: kErrorColor));
//           }
//           if (SharedPreferencesService.find.get(refreshTokenKey) != null) {
//             await AuthenticationService.find.renewToken();
//             return await request(RequestTypeExtension.fromString(response.request!.method), response.request!.url.path, body: response.body, sendToken: true);
//           } else {
//             AuthenticationService.find.logout();
//           }
//         } else {
//           if (kDebugMode) {
//             Helper.snackBar(
//                 message: jsonDecode(response.body)['message'].toString().tr,
//                 title: 'debug oups!',
//                 includeDismiss: false,
//                 styleMessage: AppFonts.x12Regular.copyWith(color: kErrorColor));
//           }
//         }
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw UnauthorisedException(jsonDecode(response.body)['message'].toString());
//       case 404:
//         if (kDebugMode) {
//           Helper.snackBar(
//               message: jsonDecode(response.body)['message'], title: 'debug oups!', includeDismiss: false, styleMessage: AppFonts.x12Regular.copyWith(color: kErrorColor));
//         }
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw NotFoundException(response.body.toString());
//       case 406:
//         if (kDebugMode) {
//           Helper.snackBar(
//               message: jsonDecode(response.body)['message'], title: 'debug oups!', includeDismiss: false, styleMessage: AppFonts.x12Regular.copyWith(color: kErrorColor));
//         }
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw UnauthorisedException(jsonDecode(response.body)['message'].toString());
//       case 409:
//         if (kDebugMode) {
//           Helper.snackBar(
//               message: jsonDecode(response.body)['message'], title: 'debug oups!', includeDismiss: false, styleMessage: AppFonts.x12Regular.copyWith(color: kErrorColor));
//         }
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw ConflictException(response.body.toString());
//       case 500:
//       default:
//         await AnalyticsService.find.logErrorEvent(response.body.toString());
//         throw FetchDataException(
//           'Error occured while Communication with Server with StatusCode : ${response.statusCode}\n${response.body}',
//         );
//     }
//   }
// }