# RickAndMorty

This iOS application fetches data from the [Rick and Morty API](https://rickandmortyapi.com/) and displays a list of characters in a paginated manner. It allows users to filter characters by status (alive, dead, unknown) and view detailed information about each character, built with Swift using MVVM-C architecture.

## ✨ Features
- **Characters List Screen**: Paginated table view (20 characters per page) with name, image, gender, and species, plus filtering by status (Alive, Dead, Unknown).
- **Character Details Screen**: This screen displays the character's name, image, species, status, location, and gender.

## 🏗 Technical and Development Practices
- **Architecture**:
    - **MVVM-C (Model-View-ViewModel-Coordinator)**: Coordinators handle navigation and ViewModels manage business logic.
      
- **Dependency Injection**: Injects dependencies (e.g., CharactersUseCase, NetworkService) into ViewModels and Coordinators for testability.

- **UI Implementation**:
    - **UIKit**: Used for the main UITableView to display the list of characters.
    - **SwiftUI**: Used for smaller views (e.g., filters, loading indicators, error views) to leverage SwiftUI's declarative syntax.
      
-  **Networking**:
    - **Generic Network Layer**: Built using async/await for asynchronous API calls and supports multiple environments (Development, Staging, Production).
      
-  **Image Handling and Caching**:
    - **AsyncImage and NSCache**: Used to load and display character images asynchronously and then cache images per session to improve performance and reduce redundant network calls.
      
 -  **Code Organization**: 
     - **Grouped by Feature**
     - **Swift Package Manager (SPM):** Modularized the app into three SPMs (Data, Domain, and Networking).
       
-  **Environments**: Three environments are supported (Development, Staging, and Production).
-  **Unit Tests**: Written for ViewModels and Use Cases to ensure business logic works as expected.
-   **No External Dependencies** 

## 🚀 Instructions for Building and Running  
   ```bash
    git clone https://github.com/El-Attar1234/RickAndMorty.git
   ```
  - Launch RickAndMorty.xcodeproj in Xcode.
  - To run the project: Select your scheme , simulator and then press Cmd + R
  - To run tests: Press Cmd + U

##  📝 Assumptions and Decisions
  - API returns 20 characters per page by default.
  - Single base URL used, extensible to Development, Staging, and Production.
  - Images cached in memory for the session.

##  🛠 Challenges and Solutions
  -  **Image Loading**: Used AsyncImage with NSCache for efficient loading and caching.
  -  **Pagination**: Triggered loading of more data 5 items from the end of the list.
  -  **Testing asynchronous code**: Used XCTestExpectation to handle async operations in tests.
  -  **Managing Navigation Flow**: Implemented the Coordinator pattern to separate and manage navigation logic.

##  📸 Screenshots and Demo
- [Demo](https://drive.google.com/file/d/1BmJYJpigvmUNPhG3tAHqHxenK0oakjnr/view?usp=drive_link)
 ---
  
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/65d1cb78-0707-42ad-a60c-53d27f2c7728"> 
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/539f6fc2-ba93-4aa7-b869-f8f8f9eb9d4b">
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/6a9d2544-6d05-44e2-b60c-96811ff657fe">
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/2a5907f0-9044-4d05-9c31-d2ebfd8c8edd">
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/7d9ef00a-7220-4206-9563-f3399873db29">
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/1eb9682f-26bf-4129-8cef-b675278c2289">
<img width="200" alt="Details" src="https://github.com/user-attachments/assets/4b6fd715-cd3d-408c-af56-1098ba367a03">





