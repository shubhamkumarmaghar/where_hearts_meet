import 'dart:developer';
import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:where_hearts_meet/utils/secret_keys/aws_secret_keys.dart';

class FunctionsService {
  static Future<String> uploadFileToAWS({required String eventKey, required File file}) async {
    try {
      final url = await AwsS3.uploadFile(
          accessKey: awsAccessKey,
          secretKey: awsSecretKey,
          file: file,
          key: eventKey,
          bucket: awsBucket,
          region: awsRegion,
          metadata: {"test": "test"} // optional
          );

      if (url != null) {
        return url;
      } else {
        log('some issue ');
      }
    } catch (e) {
      log('Error :: ${e.toString()},$file----$eventKey');
      return '';
    }
    return '';
  }
}
