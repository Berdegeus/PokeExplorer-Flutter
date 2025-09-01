# Poke Explorer Pokédex App

Poke Explorer is an interactive Pokédex application built with Flutter. It allows users to browse, search, and save their favorite Pokémon by consuming data from the public [PokéAPI](https://pokeapi.co/).

This project was developed as a final assignment for the Mobile Application Development discipline at the **Pontifical Catholic University of Paraná (PUCPR)**. It demonstrates the implementation of modern app development concepts, including clean architecture, state management, and asynchronous API consumption.

-----

## ✨ Features

  - **Browse Pokémon:** View an extensive list of Pokémon with an infinite scroll "Load More" feature.
  - **Search Functionality:** Find any Pokémon by its name or Pokédex number.
  - **Detailed View:** Get detailed information for each Pokémon, including its image, types, abilities, height, weight, and base stats.
  - **Favorites System:** Mark your favorite Pokémon and view them all on a dedicated screen.
  - **Clean UI/UX:** A user-friendly interface that provides feedback with loading indicators and error messages.

-----

## 🛠️ Tech Stack & Architecture

This project was built with a focus on creating a scalable, testable, and maintainable codebase.

  - **Framework:** **Flutter**
  - **Language:** **Dart**
  - **Architecture:** **Clean Architecture**, separating the app into three distinct layers:
      - `Data`: Handles data retrieval from the PokéAPI and local sources.
      - `Domain`: Contains the core business logic and entities, independent of any framework.
      - `Presentation`: Manages the UI and user interaction, built using the **Atomic Design** pattern.
  - **State Management:** **Provider** package, for managing the state of favorites and the Pokémon list globally.
  - **API Client:** **`http`** package for making asynchronous requests to the PokéAPI.

-----

## 📂 Project Structure

The project's folder structure is organized according to the principles of Clean Architecture and Atomic Design.

```
lib/
├── data/          # Data Layer (Repositories, Models, Data Sources)
├── domain/        # Domain Layer (Entities, Use Cases, Repository Contracts)
└── presentation/  # Presentation Layer
    ├── providers/   # State Management (ChangeNotifiers)
    └── ui/
        ├── atoms/     # Smallest reusable widgets (e.g., a styled chip)
        ├── molecules/ # Combinations of atoms (e.g., a Pokémon card)
        ├── organisms/ # Complex UI components (e.g., the Pokémon grid)
        └── pages/     # The app screens (Pokédex, Details, Favorites)
```

-----

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

  - Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
  - An IDE like VS Code or Android Studio with the Flutter plugin.

### Installation & Setup

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/berdegeus/poke_explorer.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd poke_explorer
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the app:**
    ```sh
    flutter run
    ```