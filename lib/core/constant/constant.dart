class Constant {
  static String api =
      "https://gear-mai-void-usgs.trycloudflare.com/api";
  static String domain =
      "https://gear-mai-void-usgs.trycloudflare.com";

  static String endpoint(final String destination) {
    return "https://gear-mai-void-usgs.trycloudflare.com/api$destination";
  }
}
