enum ResetPasswordResponse {
  ok,
  networkRequestFailed,
  userDisabled,
  userNotFound,
  tooManyRequest,
  unknown,
}

ResetPasswordResponse stringToResetPasswordRespone(String code) {
  switch (code) {
    case "internal-error":
      return ResetPasswordResponse.tooManyRequest;
    case "user-not-found":
      return ResetPasswordResponse.userNotFound;
    case "user-disabled":
      return ResetPasswordResponse.userDisabled;
    case "network-requesd-failed":
      return ResetPasswordResponse.networkRequestFailed;
    default:
      return ResetPasswordResponse.unknown;
  }
}
