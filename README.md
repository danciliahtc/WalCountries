# 🌍 WalCountries

WalCountries is an iOS application built using **Swift**, following the **MVVM architecture pattern**. The app fetches and displays a list of countries from a remote JSON endpoint and allows users to search by name or capital city.

<br>

## 🚀 Features

- 📡 Fetches country data from a remote API
- 🔎 Live search functionality (by name or capital)
- 🧭 Clean UI using `UITableView`
- 🧠 MVVM architecture for better separation of concerns
- 🧪 Fully unit-tested with mocks for network and view model layers
- ♿️ Supports accessibility and dynamic type

<br>

## 🛠 Technologies Used

- **Swift 5**
- **UIKit**
- **MVVM Design Pattern**
- **Unit Testing with XCTest**
- **Custom Networking Layer using `URLSession`**
- **Mocking for testability**

<br>

## 📦 Architecture

This app follows the **MVVM** pattern:

```
ViewController (View)
     ⬇️
 ViewModel
     ⬇️
NetworkManager (Service Layer)
```

- `CountriesViewController`: Handles UI and table view interactions
- `CountriesViewModel`: Contains business logic and data transformations
- `NetworkManager`: Handles fetching and decoding remote JSON data
- `Country`: Model conforming to `Decodable`
- `CountryCell`: Custom cell for table view presentation

<br>

## 🧪 Unit Testing

Tests cover the following layers:

| Test File                      | What It Tests                                              |
|-------------------------------|------------------------------------------------------------|
| `CountriesViewControllerTests` | TableView rendering and search bar integration             |
| `CountriesViewModelTests`      | Data logic, filtering, delegate calls                      |
| `CountryCellTests`             | UILabel configuration and accessibility                    |
| `CountryModelTests`            | JSON decoding for the `Country` model                      |
| `NetworkManagerTests`          | Error handling and decoding logic in the network layer     |

Mocked dependencies include:
- `MockNetworkManager`
- `MockCountriesViewModel`
- `MockCountriesViewModelDelegate`


## 🔧 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/WalCountries.git
   ```

2. Open the project in Xcode:
   ```bash
   cd WalCountries
   open WalCountries.xcodeproj
   ```

3. Build and run the app using `⌘R`.

4. To run tests:
   ```bash
   ⌘U or Product > Test
   ```

<br>

## 🌐 Data Source

- JSON endpoint:  
  [Countries API (Gist)](https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json)

<br>

## 📚 Learn More

- [MVVM in iOS](https://medium.com/@azamsharp/mvvm-in-ios-from-zero-to-hero-dc478b44b40a)
- [Unit Testing in Swift](https://developer.apple.com/documentation/xctest)

<br>

## ✨ Future Improvements

- Dark mode support
- Pagination for large datasets
- Pull-to-refresh
- Localization
- CI/CD for automated tests

<br>

## 👩🏾‍💻 Author

**Dancilia Harmon**  
Built with love and a passion for clean code ✨  
📬 https://www.linkedin.com/in/dancilia-harmon-462910355/ | 📧 harmondancilia@gmail.com

<br>

## 📝 License

This project is open source and available under the [MIT License](LICENSE).
