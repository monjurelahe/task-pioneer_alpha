# GitHub Repository Viewer: Top 50 Flutter Repositories

## Project Overview

This project is a Flutter mobile application developed to fulfill the technical assessment task for Pioneer Alpha Ltd. The application's core function is to interface with the **GitHub Search API** to retrieve, display, and manage the **top 50 most starred repositories** filtered by the keyword `"Flutter"`.

The architecture is structured using **GetX** for robust state management, routing, and dependency injection, ensuring a clean, maintainable, and scalable codebase.

### Core Features Implemented

* **Data Fetching:** Successfully retrieves the top 50 most popular repositories using the required GitHub API endpoint (`/search/repositories`).
* **Offline Support (Persistence):** Utilizes `shared_preferences` to cache the fetched repository list, enabling users to browse data even without an active internet connection. Previously fetched data persists across app sessions.
* **Sorting Functionality:** Implements dynamic sorting of the repository list based on:
    * Star Count (default)
    * Last Updated Date/Time
* **Persistence of Sort Order:** The user's selected sorting preference (stars or date) is saved locally and applied automatically upon subsequent app launches.
* **Detailed View:** A dedicated screen displays comprehensive details for a selected repository, including owner information (name, profile photo), repository description, and the last update date-time formatted as **MM-DD-YYYY HH:MM**.
* **Error Handling:** Robust handling for API failures, network interruptions, and data parsing errors.

## 💻 How to Run the App

Follow these steps to set up and run the application on your local machine.

### Prerequisites

* Flutter SDK (v3.16.0 or higher recommended)
* A physical device or an active emulator/simulator.

### Installation and Execution Steps

1.  **Clone the Repository:**
    ```bash
    git clone "https://github.com/monjurelahe/task-pioneer_alpha/"
    cd pioneer_aplha
    ```

2.  **Install Dependencies:**
    Fetch all required packages listed in `pubspec.yaml`:
    ```bash
    flutter pub get
    ```

3.  **Generate Model Code (If applicable):**
    If using `json_serializable` for model generation, run the build runner:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the Application:**
    Ensure a device is connected, and run the app:
    ```bash
    flutter run
    ```

## 📦 Dependencies Used

The following key packages were utilized to build the application and meet the functional and quality requirements:

| Dependency | Purpose |
| :--- | :--- |
| `get` | Comprehensive library for State Management, Routing, and Dependency Injection (DI). |
| `dio` | A powerful and customizable HTTP client for handling API calls efficiently. |
| `shared_preferences` | Used for local data persistence, specifically for caching the repository list and saving the user's sorting preference. |
| `intl` | Provides internationalization and formatting utilities, specifically used for date and time formatting (MM-DD-YYYY HH:MM). |
| `json_annotation` / `build_runner` | Facilitates reliable and safe JSON serialization and deserialization for data models. |

---
**[Created by: Md. Monjur E Elahe / monjurelahe]**
