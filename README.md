# DataWow iOS Developer Coding Challenge

## Project Documentation
### Description
This project displays a list of Pokemon fetched from the PokeAPI, allowing users to search for specific Pokémon by name and view their basic details in a separate screen.

## Features
- MVVM architecture with input-output bindings
- Supports multiple screen sizes
- Fetches Pokemon list list from an API
- Pull-to-refresh functionality
- Search functionality
- Displays detailed information about each Pokemon

## Requirements
- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

### Setup and Run Instructions
1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the project on a simulator or device.

### Time Spent
Approximately 24 hours.

### Known Edge Cases and Limitations
- SVG images may not load correctly on the first attempt due to asynchronous loading.
- Unable to search by Pokemon id.

## Testing
Not included in this challenge.

## Libraries Used
- [SVGKit](https://github.com/SVGKit/SVGKit): For SVG image.
- [Kingfisher](https://github.com/onevcat/Kingfisher): For asynchronous image loading and caching.

## License
This project is licensed under the [MIT License](LICENSE).
