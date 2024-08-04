import 'dart:developer';
import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_s3/simple_s3.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:where_hearts_meet/utils/secret_keys/aws_secret_keys.dart';

class FunctionsService {
  static Future<String> uploadFileToAWS({required File file}) async {
    try {
      var path = file.path.split('/');
      log('video file :: ${path.last} ');
      final url = await AwsS3.uploadFile(
        accessKey: awsAccessKey,
        secretKey: awsSecretKey,
        acl: ACL.public_read,
        file: file,
        key: path.last,
        bucket: awsBucket,
        region: awsRegion,
      );

      if (url != null) {
        return url;
      } else {
        log('some issue $url');
      }
    } catch (e) {
      log('Error :: ${e.toString()},$file');
    }
    return '';
  }

  static Future<String> uploadFileToAWSS3({required File file}) async {
    try {
      var path = file.path.split('/');
      log('video file :: ${path.last} ');
      SimpleS3 simpleS3 = SimpleS3();

      final url = await simpleS3.uploadFile(
        file,
        awsBucket,
        'arn:aws:s3:::hehbucket',
        AWSRegions.apSouth1,
        fileName: path.last,
        debugLog: true,
        accessControl: S3AccessControl.publicRead,
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

  static Future<String?> generateThumbnail(String videoUrl) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 80,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return fileName;
  }
}
