class BuyCodeParams {
  final String token;
  final String platformId;

  BuyCodeParams(this.token, this.platformId);

  Map<String, dynamic> toJson() => {
        "token": token,
        "platform_id": platformId,
      };
}
