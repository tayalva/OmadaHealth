# Omada Movie Database iOS App

This is the iOS interview home assignment for **Omada Health**. The app allows users to search for movies and view detailed information using The Open Movie Database (TMDB) API.

## Goals

This project demonstrates:

- iOS development skills using Swift and SwiftUI (or UIKit + SwiftUI)
- Clean, testable architecture
- Integration with a REST API
- Responsive UI that updates as the user types
- Basic unit testing, error handling, and documentation

## Features

### Main Screen
- Search bar at the top to query movie titles
- Results displayed dynamically as the user types
- “No results” label when no movies match the query
- Scrollable list of search results
- Each movie row includes:
  - Cover image
  - Movie title
  - Release year
- Tapping a movie navigates to the detail screen

### Detail Screen
- Top section:
  - Movie title
  - Full release date
  - Cover image
  - Viewer rating with visual representation
- Lower section:
  - Movie overview and additional details
                                                    
## Extras

- Added a few small units tests for APIManager and MovieSearch.ViewModel
- Added documentation for each file
- Used KingFisher for image loading and caching. I wrapped this in ImageFetcher to allow for easier changes away from KingFisher if needed, without affecting the rest of the code.
                                                    
                                                    
## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/tayalva/OmadaHealth

## Recordings

App walkthrough: https://www.loom.com/share/2e7bf92e9ccd43e58559d38f55fb9c5a?sid=e4e6e462-6318-4c96-ad61-2760a351e08a
AI Usage: https://www.loom.com/share/9542f6dd580840619ad04c1e2ec5435c?sid=8ca9066f-f19f-4fd6-9670-9f4543bb6fd2
