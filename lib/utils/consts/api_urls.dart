class AppUrls {
  static const String prodUrl = "https://heartehomies.com/";
  static const String homeUrl = "http://192.168.1.14:8000/";
  static const String baseUrl = prodUrl;

  static const String termsAndConditionsUrl = '${prodUrl}termsandconditions/';
  static const String privacyPolicyUrl = '${prodUrl}privacy/';

  static const String loginUrl = 'userPolls/login/';
  static const String signUpUrl = 'userPolls/signup/';
  static const String userAccountUrl = 'userPolls/get_user/';
  static const String uploadFileUrl = 'userPolls/upload_file/';
  static const String uploadVideoUrl = 'userPolls/upload_video/';
  static const String deleteFileUrl = 'userPolls/delete_file/';

  ///created by me
  static const String eventsCreatedByUserUrl = 'eventApp/get_events_list/';

  static const String getGiftsUrl = 'eventApp/gifts_list/';

  ///for guest
  static const String receiveEventUrl = 'eventApp/get_event_receiver/';
  static const String personalWises = 'wishesApp/personal_wishes/';

  ///created for me
  static const String eventsCreatedForUserUrl = 'eventApp/get_events_list_receiver/';

  static const String createEventUrl = 'eventApp/events/';
  static const String eventWishesUrl = 'wishesApp/wishes/';
  static const String personalWishesUrl = 'wishesApp/personal_wishes/';
  static const String personaMemoriesUrl = 'wishesApp/personal_memories/';
  static const String personaMessagesUrl = 'wishesApp/personal_messages/';
  static const String personalDecorationsUrl = 'wishesApp/decorations/';
  static const String giftsUrl = 'eventApp/gifts/';
}
