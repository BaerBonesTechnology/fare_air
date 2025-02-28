# Fare Air
### Description
Fare Air is an application that allows users to search for flights and hotels based on origin and destination.

### Api

#### For the application I implemented the following APIs:
 [Air Scraper](https://rapidapi.com/apiheya/api/sky-scrapper) - This API was used to get the flight details.

## Design Decisions
- I used the MVC design pattern to separate the concerns of the application.
- For state management I used Riverpod.
- for my interactive UI the goal was to inform the user of the price of certain flights available so I settled for a simple bottom sheet that would display the price of the flight when the user clicks a flight itinerary.

### Third Party Libraries
- Riverpod
- Dio
- Intl
- Permission Handler
- Shared Preferences
- Json Serializable
- Json Annotation

### Running instructions
- if using Android Studio, it should be able to open and run the project without any issues. However if you are using any other IDE, run the following in your terminal:
```bash
flutter run --dart-define-from-file=config/config.json
```