
class LoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  LoadingState({required this.loadingType, this.error, this.completed});
}

enum LoadingType { stable,loading, loaded, completed, error }