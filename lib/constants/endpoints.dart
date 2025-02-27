const String baseUrl = 'https://sky-scrapper.p.rapidapi.com/api/v1';
const String baseUrlV2 = 'https://sky-scrapper.p.rapidapi.com/api/v2';
const String checkServerUrl = '$baseUrl/checkServer';
const String getNearbyAirportsUrl =
    '$baseUrl/flights/getNearByAirports?lat={lat}&lng={lon}&locale={locale}';
const String getAirportByQueryUrl =
    '$baseUrl/flights/searchAirport?query={query}&locale={locale}';
const String getFlightSearchUrl = '$baseUrl/flights/searchFlights?'
    'originSkyId={originSkyId}'
    '&destinationSkyId={destinationSkyId}'
    '&originEntityId={originEntityId}'
    '&destinationEntityId={destinationEntityId}'
    '&date={date}';
const String skyScrapperHost = 'sky-scrapper.p.rapidapi.com';
