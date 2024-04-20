enum LoadingDataStatus {
  loading,
  error,
  errorOther,
  ready,
}

enum LoginStatus {
  idle,
  loading,
  errorPasses,
  errorOffline,
  errorOther,
  confirmed
}

enum SignUpStatus {
  idle,
  loading,
  errorOffline,
  errorOther,
  errorPasswordMatch,
  errorAccountExistsOrFormat,
  confirmed
}

enum AllListsStatus { loading, errorOffline, errorOther, empty, loaded }

enum ListDetailsStatus {loading, error, empty, loaded }