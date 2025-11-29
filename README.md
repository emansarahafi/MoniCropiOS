# MoniCrop iOS

A SwiftUI-based iOS application for smart crop monitoring, enabling farm and business owners to track environmental data and manage crop inventories on their mobile devices.

[View interactive prototype on Figma](https://www.figma.com/proto/tVz1lMvEEfc3UZvJ6FqLNd/COSC-348---CMPE-495A-Wireframes?node-id=1451-5057&p=f&t=GpWxWu3EK2lZuChZ-1&scaling=scale-down&content-scaling=fixed&page-id=1408%3A4502&starting-point-node-id=1451%3A5057&show-proto-sidebar=1)

![COSC 348   CMPE 495A Wireframes (3)](https://github.com/user-attachments/assets/062d432d-f660-4f28-b576-d768fa13a394)

## Overview

MoniCrop was developed as part of a Mobile Programming 1 (COSC 348) capstone project. The app complements a larger smart crop monitoring system by providing a mobile interface for viewing real-time farm data that would traditionally be displayed on a website.

## Features

### User Management

- **Authentication System**: Sign in, sign up, and password recovery
- **Account Types**: Support for Farm Owners and Business Owners
- **Profile Management**: Edit account details, disable, or delete accounts

### Data Monitoring

Track key agricultural metrics in real-time:

- Humidity levels
- pH levels
- Salinity levels
- Water levels
- Growth speed
- Soil temperature

### Inventory Management

- View and manage crop items (Mango, Apple, Carrot, Strawberry, Pear)
- Track pricing and planting dates
- Visual item listings with images

### Additional Features

- **Workplace Details**: View company and farm information
- **Customer Feedback**: Submit feedback and complaints
- **Resource Access**: Links to PDF brochures and Telegram channels
- **Hamburger Menu Navigation**: Intuitive side menu interface

## Technical Details

- **Framework**: SwiftUI
- **Platform**: iOS
- **Language**: Swift
- **Architecture**: MVVM pattern with `@StateObject` and `@EnvironmentObject`

## Screenshots

![COSC348 - Poster Presentation Final Draft](https://github.com/emansarahafi/MoniCropiOS/assets/85173630/39233a7a-ab99-4489-85b7-138c18ee0463)

## Getting Started

1. Clone the repository
2. Open `MoniCrop.xcodeproj` in Xcode
3. Build and run the project on your iOS device or simulator

## Project Structure

```
MoniCrop/
├── MoniCropApp.swift          # App entry point
├── ContentView.swift          # Landing page
├── SignInView.swift           # Authentication
├── SignUpView.swift           # User registration
├── WelcomeView.swift          # Main menu & navigation
├── ViewData.swift             # Environmental data charts
├── ViewItems.swift            # Crop inventory
├── WorkplaceView.swift        # Business details
├── CustomerView.swift         # Feedback submission
├── EditAccountView.swift      # Profile management
├── Components.swift           # Reusable UI components
└── Assets.xcassets/          # Images and resources
```

## Authors

- **Ali Abdulla**
- **Eman Sarah Afi**

Developed at American University of Bahrain (AUBH), 2022-2023

## License

Educational project - developed for COSC 348 Mobile Programming course.
