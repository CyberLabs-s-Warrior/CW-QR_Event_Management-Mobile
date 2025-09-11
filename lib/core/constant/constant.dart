class Constant {
  static String api = "http://192.168.1.16:8000/api";
  static String domain = "http://192.168.1.16:8000";

  static String endpoint(final String destination) {
    return "http://192.168.1.16:8000/api$destination";
  }
}
