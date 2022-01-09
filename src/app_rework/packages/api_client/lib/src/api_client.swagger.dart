import 'api_client.models.swagger.dart';
import 'package:chopper/chopper.dart';
import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'api_client.enums.swagger.dart' as enums;
export 'api_client.enums.swagger.dart';
export 'api_client.models.swagger.dart';

part 'api_client.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class ApiClient extends ChopperService {
  static ApiClient create([ChopperClient? client]) {
    if (client != null) {
      return _$ApiClient(client);
    }

    final newClient = ChopperClient(
        services: [_$ApiClient()],
        converter: $JsonSerializableConverter(),
        baseUrl: 'https://');
    return _$ApiClient(newClient);
  }

  ///
  ///@param skip
  ///@param take
  Future<chopper.Response<GetAffirmationListQueryResponseDto>>
      AffirmationsApiController_getAffirmationList(
          {required num? skip, required num? take}) {
    generatedMapping.putIfAbsent(GetAffirmationListQueryResponseDto,
        () => GetAffirmationListQueryResponseDto.fromJsonFactory);

    return _AffirmationsApiController_getAffirmationList(
        skip: skip, take: take);
  }

  ///
  ///@param skip
  ///@param take
  @Get(path: '/api/v1/affirmations')
  Future<chopper.Response<GetAffirmationListQueryResponseDto>>
      _AffirmationsApiController_getAffirmationList(
          {@Query('skip') required num? skip,
          @Query('take') required num? take});

  ///
  Future<chopper.Response<AffirmationDto>>
      AffirmationsApiController_createAffirmation(
          {required CreateAffirmationCommandDto? body}) {
    generatedMapping.putIfAbsent(
        AffirmationDto, () => AffirmationDto.fromJsonFactory);

    return _AffirmationsApiController_createAffirmation(body: body);
  }

  ///
  @Post(path: '/api/v1/affirmations')
  Future<chopper.Response<AffirmationDto>>
      _AffirmationsApiController_createAffirmation(
          {@Body() required CreateAffirmationCommandDto? body});

  ///
  ///@param id
  Future<chopper.Response<AffirmationObjectResponseDto>>
      AffirmationsApiController_toggleAffirmationLike({required num? id}) {
    generatedMapping.putIfAbsent(AffirmationObjectResponseDto,
        () => AffirmationObjectResponseDto.fromJsonFactory);

    return _AffirmationsApiController_toggleAffirmationLike(id: id);
  }

  ///
  ///@param id
  @Put(path: '/api/v1/affirmations/{id}', optionalBody: true)
  Future<chopper.Response<AffirmationObjectResponseDto>>
      _AffirmationsApiController_toggleAffirmationLike(
          {@Path('id') required num? id});

  ///
  Future<chopper.Response<UserDto>> UsersApiController_signUpUser(
      {required SignUpCommandDto? body}) {
    generatedMapping.putIfAbsent(UserDto, () => UserDto.fromJsonFactory);

    return _UsersApiController_signUpUser(body: body);
  }

  ///
  @Post(path: '/api/v1/users')
  Future<chopper.Response<UserDto>> _UsersApiController_signUpUser(
      {@Body() required SignUpCommandDto? body});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
