abstract class ApiHelper {
  static const mainUrl = 'https://api.data.gov.sg/v1';
  static const trafficImages = '/transport/traffic-images';

  static final trafficImagesUrl = Uri.parse(mainUrl + trafficImages);
}