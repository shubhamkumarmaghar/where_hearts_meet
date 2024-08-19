import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';
import 'package:where_hearts_meet/create_event/model/event_model.dart';
import 'package:where_hearts_meet/create_event/model/event_response_model.dart';
import 'package:where_hearts_meet/create_event/model/gift_model.dart';
import 'package:where_hearts_meet/create_event/model/gifts_data_model.dart';
import 'package:where_hearts_meet/create_event/model/personal_wishes_model.dart';
import 'package:where_hearts_meet/create_event/model/wishes_model.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';
import 'package:where_hearts_meet/utils/model/image_response_model.dart';
import 'package:where_hearts_meet/utils/widgets/util_widgets/app_widgets.dart';

import '../../utils/consts/api_urls.dart';
import '../../utils/services/api_service.dart';
import '../model/personal_memories_model.dart';
import '../model/timeline_model.dart';

class CreateEventService {
  final ApiService _apiService = ApiService();

  Future<ImageResponseModel?> uploadImageApi({required File imageFile}) async {
    final img = await dio.MultipartFile.fromFile(imageFile.path,
        filename: (imageFile.path.split('/')).last, contentType: MediaType('image', (imageFile.path.split('.')).last));

    final response = await _apiService.formDataPostApiCall(url: AppUrls.uploadFileUrl, data: {'file': img});

    return response['data'] != null ? ImageResponseModel.fromJson(response['data']) : null;
  }

  Future<ImageResponseModel?> uploadVideoApi({required File videoFile}) async {
    final video = await dio.MultipartFile.fromFile(videoFile.path,
        filename: (videoFile.path.split('/')).last, contentType: MediaType('video', (videoFile.path.split('.')).last));

    final response = await _apiService.formDataPostApiCall(url: AppUrls.uploadVideoUrl, data: {'file': video});

    return response['data'] != null ? ImageResponseModel.fromJson(response['data']) : null;
  }

  Future<EventResponseModel?> createEventApi({required EventModel eventModel}) async {
    eventModel.hostName = 'Deepak';
    eventModel.globalEvent = false;

    String url = AppUrls.createEventUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: eventModel.toJson(),
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('event created')) {
      AppWidgets.getToast(message: data['message'], color: greenTextColor);
      return EventResponseModel.fromJson(data['data']);
    }
    return null;
  }

  Future<WishesModel?> addWishesEventApi({required WishesModel wishesModel}) async {
    String url = AppUrls.eventWishesUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: wishesModel.toJson(),
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('wishes created')) {
      AppWidgets.getToast(message: data['message'], color: greenTextColor);
      return WishesModel.fromJson(data['data']);
    }
    return null;
  }

  Future<TimelineModel?> addTimelineStoriesEventApi(
      {required String eventId, required List<String> imagesList, required List<String> videosList}) async {
    String url = AppUrls.eventTimelineUrl;
    final response = await _apiService.postApiCall(
      url: url,
      data: {"event_id": eventId, "images": imagesList, "videos": videosList},
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('timeline created')) {
      AppWidgets.getToast(message: data['message'], color: greenTextColor);
      return TimelineModel.fromJson(data['data']);
    }
    return null;
  }

  Future<PersonalWishesModel?> addPersonalWishesApi({required PersonalWishesModel model}) async {
    String url = AppUrls.personalWishesUrl;

    final response = await _apiService.postApiCall(
      url: url,
      data: model.toJson(),
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('personal wishes created')) {
      return PersonalWishesModel.fromJson(data['data']);
    }
    return null;
  }

  Future<GiftModel?> addGiftsEventApi({required GiftModel giftModel}) async {
    String url = AppUrls.giftsUrl;

    final response = await _apiService.postApiCall(
      url: url,
      data: giftModel.toJson(),
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('gifts created ')) {
      AppWidgets.getToast(message: data['message'], color: greenTextColor);
      return GiftModel.fromJson(data['data']);
    }
    return null;
  }

  Future<List<GiftsCard>?> getGiftsApi() async {
    String url = AppUrls.getGiftsUrl;
    final response = await _apiService.getApiCall(
      url: url,
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('gifts') && data['data'] != null) {
      Iterable iterable = data['data'];

      return iterable.map((gift) => GiftsCard.fromJson(gift)).toList();
    } else {
      return null;
    }
  }

  Future<PersonalMemoriesModel?> addPersonalMemoriesApi({required PersonalMemoriesModel model}) async {
    String url = AppUrls.personaMemoriesUrl;

    final response = await _apiService.postApiCall(
      url: url,
      data: model.toJson(),
    );
    final data = response;

    if (data['message'].toString().toLowerCase().contains('personal memories created')) {
      AppWidgets.getToast(message: data['message'], color: greenTextColor);
      return PersonalMemoriesModel.fromJson(data['data']);
    }
    return null;
  }
}
