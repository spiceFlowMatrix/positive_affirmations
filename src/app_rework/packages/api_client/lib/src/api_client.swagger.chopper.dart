//Generated code

part of 'api_client.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiClient extends ApiClient {
  _$ApiClient([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiClient;

  @override
  Future<Response<GetAffirmationListQueryResponseDto>>
      _AffirmationsApiController_getAffirmationList(
          {required num? skip, required num? take}) {
    final $url = '/api/v1/affirmations';
    final $params = <String, dynamic>{'skip': skip, 'take': take};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<GetAffirmationListQueryResponseDto,
        GetAffirmationListQueryResponseDto>($request);
  }

  @override
  Future<Response<AffirmationDto>> _AffirmationsApiController_createAffirmation(
      {required CreateAffirmationCommandDto? body}) {
    final $url = '/api/v1/affirmations';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AffirmationDto, AffirmationDto>($request);
  }

  @override
  Future<Response<AffirmationObjectResponseDto>>
      _AffirmationsApiController_toggleAffirmationLike({required num? id}) {
    final $url = '/api/v1/affirmations/${id}';
    final $request = Request('PUT', $url, client.baseUrl);
    return client.send<AffirmationObjectResponseDto,
        AffirmationObjectResponseDto>($request);
  }
}
