export type OnfidoAuthConfig = {
  sdkToken: string;
  retryCount?: number;
};

export type OnfidoAuthResult = {
  token: string;
  uuid: string;
  verified: boolean;
};
