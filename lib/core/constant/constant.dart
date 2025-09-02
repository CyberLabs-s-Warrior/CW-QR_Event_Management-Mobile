class Constant {
  static String api =
      "https://engineers-contrary-pages-intellectual.trycloudflare.com/api";
  static String domain =
      "https://engineers-contrary-pages-intellectual.trycloudflare.com";
  static String endpoint(final String destination) {
    return "https://engineers-contrary-pages-intellectual.trycloudflare.com/api$destination";
  }
}