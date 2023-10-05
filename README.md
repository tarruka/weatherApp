
# WeatherApp
 <img style="width: 300px;" src="https://github.com/tarruk/weatherApp/assets/36048605/22c0b9a8-4f89-475a-8005-e6c4029cc561">

### Description
WeatherApp is a simple, SwiftUI-based weather application designed to provide real-time weather updates and essential information for various locations. It offers a seamless user experience, allowing users to effortlessly check weather conditions, city names, and other vital details for different places.

![demo-weather](https://github.com/tarruk/weatherApp/assets/36048605/c8ea0fa6-4b1c-4a4d-a7f6-067237346e61)


### Principal features
- Current Weather Information: Get instant weather updates, city names, and basic details for:
    - Your current location
    - Montevideo
    - Buenos Aires
    - London

### Aditionals features
- Favorite Locations: The app provide local persistence to allow you to save your favorite weathers and access their data any time.

- Dynamic UI: Enjoy a visually appealing interface that adapts based on the time of day and weather conditions:
    - Light theme for daytime
    - Dark theme for nighttime
    - Dynamic shadows and more.

- Interactive Animations: Engage with the app through smooth animations that enhance user interaction.

- Weather Detail: It's possible to access detailed weather information for each location by simply clicking on it. This feature provides in-depth weather details.

### Technical decisions
- Efficient Icon Loading: Weather icons, being known and finite, are preloaded as project assets to prevent delays in fetching images, resulting in a much better user experience.

- City Information API: Assumed the existence of an in-house API service to fetch city details like IDs and correct names. This data is crucial for weather data retrieval. City information is stored locally as a JSON file and accessed using the `CitiesService` class.

- Error Handling: While error handling was implemented in this project, only a few specific errors, mostly related to networking, were deliberately included for demonstration purposes.

- Networking Management: The networking layer is as basic as the needs of the project require. that said there is a lot of room for improvement in this area (and the other ones)

