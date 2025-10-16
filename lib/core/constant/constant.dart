class Constant {
  static String api = "http://10.0.2.2:8000/api";
  static String domain = "http://10.0.2.2:8000";

  static String endpoint(final String destination) {
    return "http://10.0.2.2:8000/api$destination";
  }
}
