# Netflix-Clone

**Netflix-Clone** is a Flutter-based mobile application that replicates the user interface of
Netflix. The app integrates with the TMDB (The Movie Database) API to display movie and TV show
details, including popular movies, top-rated shows, and more. This project showcases Flutter's
capability in building a modern and feature-rich user interface.

![Netflix Banner](assets/logo/cover_image.png)

## Features

- Browse popular movies and TV shows.
- View detailed information about each movie or show.
- Dynamic categories for movies and TV shows.
- Modern and stylish user interface.

## Getting Started

### Prerequisites

To run this project, you will need:

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- A valid TMDB API Key: [Get TMDB API Key](https://www.themoviedb.org/settings/api)

### Setup

1. **Clone the repository:**

    ```bash
    git clone https://github.com/DevNadimm/Netflix-Clone.git
    cd Netflix-Clone
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Add your TMDB API key:**

    - Create a `.env` file in the root directory of the project and add your TMDB API key:

    ```env
    TMDB_API_KEY=your_tmdb_api_key
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## API Integration

This app uses the [TMDB API](https://www.themoviedb.org/documentation/api) to fetch and display
movie and TV show data. To use the API, you'll need to obtain an API key from TMDB and add it to
your project.

1. **Get your API key:**
    - Sign up at [TMDB](https://www.themoviedb.org/settings/api) and obtain your API key.

2. **Add your API key:**
    - Replace the placeholder API key in the project with your own in the `.env` file.

    ```dart
    const String apiKey = 'YOUR_API_KEY_HERE';
    ```

## Contributing

Contributions are welcome! If you have any suggestions, bug reports, or feature requests, feel free
to open an issue or submit a pull request.

## Contact

If you have any questions or want to get in touch, you can reach me
at [nadimchowdhury87@gmail.com](mailto:nadimchowdhury87@gmail.com).
