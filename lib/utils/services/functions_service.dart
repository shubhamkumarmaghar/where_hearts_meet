import 'dart:developer';
import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:simple_s3/simple_s3.dart';
import 'package:where_hearts_meet/utils/secret_keys/aws_secret_keys.dart';

class FunctionsService {
  static Future<String> uploadFileToAWS({required File file}) async {
    try {
      var path = file.path.split('/');
      log('video file :: ${path.last} ');
      final url = await AwsS3.uploadFile(
        accessKey: awsAccessKey,
        secretKey: awsSecretKey,
        file: file,
        key: path.last,
        bucket: awsBucket,

        region: awsRegion,
      );

      if (url != null) {
        return url;
      } else {
        log('some issue ');
      }
    } catch (e) {
      log('Error :: ${e.toString()},$file');
      return '';
    }
    return '';
  }

  static Future<String> uploadFileToAWSS3({required File file}) async {
    try {
      var path = file.path.split('/');
      log('video file :: ${path.last} ');
      SimpleS3 simpleS3 = SimpleS3();
      simpleS3.getUploadPercentage.listen((event) {
        log('mmmm ${event}');
      });
      final url = await simpleS3.uploadFile(
        file,
        awsBucket,
        'arn:aws:s3:::hehbucket',
        AWSRegions.apSouth1,
        fileName: path.last,

        debugLog: true,
        accessControl: S3AccessControl.publicRead,

      );
      // final url = await AwsS3.uploadFile(
      //   accessKey: awsAccessKey,
      //   secretKey: awsSecretKey,
      //   file: file,
      //   key: 'hehbucket.s3.ap-south-1.amazonaws.com/birthday12_video.mp4',
      //   bucket: awsBucket,
      //   region: awsRegion,
      //
      // );

      if (url != null) {
        return url;
      } else {
        log('some issue ');
      }
    } catch (e) {
      log('Error :: ${e.toString()},$file');
      return '';
    }
    return '';
  }
}
