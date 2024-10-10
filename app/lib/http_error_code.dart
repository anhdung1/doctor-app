const Map<int, String> httpErrorMessages = {
  400: 'Bad Request',
  401: 'Unauthorized',
  403: 'Forbidden',
  404: 'Not Found',
  408: 'Request Timeout',
  500: 'Internal Server Error',
  502: 'Bad Gateway',
  503: 'Service Unavailable',
  504: 'Gateway Timeout',
};

String getErrorMessage(int statusCode) {
  return httpErrorMessages[statusCode] ?? 'Unknown error';
}
