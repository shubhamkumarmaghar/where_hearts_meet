enum Screens { fromDashboard, fromSignup }

enum EventType {
  birthday,
}

enum EventsCreated {
  forUser,
  byUser,
  pending;

  String get title {
    switch (this) {
      case EventsCreated.forUser:
        return 'Received';

      case EventsCreated.byUser:
        return 'Created';

      case EventsCreated.pending:
        return 'Pending';

      default:
        return '';
    }
  }
}

enum LoadingState { loading, hasData, noData, error }

enum AppActions { delete, view, share, edit }

enum MediaType { image, video }

enum UserType { registered, guest }
