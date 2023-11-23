import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:traffeye_sg_flutter/0_datasource/datasources/traffic_camera_datasource.dart';
import 'package:traffeye_sg_flutter/0_datasource/exceptions/exceptions.dart';
import 'package:traffeye_sg_flutter/0_datasource/models/traffic_camera_model.dart';
import 'package:traffeye_sg_flutter/1_domain/entities/traffic_camera_entity.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/api_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/box_tags_helper.dart';

import '../../3_helpers/response_helper.dart';
import 'traffic_camera_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box>()])
@GenerateNiceMocks([MockSpec<HiveInterface>()])
@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('TrafficCameraRemoteDatasource', () {
    final mockClient = MockClient();
    final mockHiveBox = MockBox<TrafficCameraEntity>();
    final mockHiveInterface = MockHiveInterface();
    const responseBody = ResponseHelper.trafficCameraRemoteDatasource;

    when(mockHiveInterface.openBox(BoxTagsHelper.cameras))
        .thenAnswer((_) async => mockHiveBox);

    final datasource =
        TrafficCameraDatasourceImpl(client: mockClient, box: mockHiveBox);

    group('should return a list of TrafficCameraModel', () {
      test('when Client response is 200 and has valid data', () async {
        final decoded = json.decode(responseBody);
        final List<dynamic> body = decoded['items'][0]['cameras'];

        List<TrafficCameraModel> matcher = [];

        for (final camera in body) {
          matcher.add(TrafficCameraModel.fromJson(camera));
        }

        when(mockClient.get(ApiHelper.trafficImagesUrl)).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)));

        final result = await datasource.fetchSnapshotsFromRemote();

        expect(result, matcher);
      });
    });

    group('should throw an exception', () {
      test('when Client response is not 200', () async {
        final matcher = throwsA(isA<ServerException>());

        when(mockClient.get(ApiHelper.trafficImagesUrl))
            .thenAnswer((realInvocation) => Future.value(Response('', 201)));

        expect(() => datasource.fetchSnapshotsFromRemote(), matcher);
      });
    });
  });
}
