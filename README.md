# MoniCrop iOS (Firebase Version)

A new release of the previous [MoniCrop iOS application](https://github.com/emansarahafi/MoniCropiOS/tree/basic-version), but now connected to Firebase.

[View interactive prototype on Figma](https://www.figma.com/proto/tVz1lMvEEfc3UZvJ6FqLNd/COSC-348---CMPE-495A-Wireframes?node-id=1451-5057&p=f&t=GpWxWu3EK2lZuChZ-1&scaling=scale-down&content-scaling=fixed&page-id=1408%3A4502&starting-point-node-id=1451%3A5057&show-proto-sidebar=1)

![COSC 348   CMPE 495A Wireframes (3)](https://github.com/user-attachments/assets/062d432d-f660-4f28-b576-d768fa13a394)

## Setup

### Required Files

Before building, you need to add the following files (not included in the repository for security):

1. **GoogleService-Info.plist** - Firebase configuration file
   - Obtain from Firebase Console for your project
   - Place in: `MoniCrop/GoogleService-Info.plist`

2. **Config.swift** - API credentials configuration
   - Create at: `MoniCrop/Config.swift`
   - Template:

   ```swift
   struct Config {
       static let telegramBotToken = "YOUR_BOT_TOKEN"
       static let telegramChatID = "YOUR_CHAT_ID"
   }
   ```

### Build Requirements

- **Xcode**: 26.1+ (Build version 17B100)
- **iOS Deployment Target**: 16.1+
- **Swift**: Latest version included with Xcode

### Known Issues & Workarounds

#### Firebase SDK Compatibility Issue (Xcode 26.1)

The project currently uses Firebase SDK 9.6.0, which has a compiler incompatibility with Xcode 26.1.

**Problem**: Build fails with error `"An attribute list cannot appear here"` in `FIRFirestoreSettings.mm:33`

**Temporary Workaround** (if build fails):

```bash
# Find the exact DerivedData path (check build logs or use this pattern)
find ~/Library/Developer/Xcode/DerivedData -name "FIRFirestoreSettings.mm" -path "*/firebase-ios-sdk/*" 2>/dev/null

# Apply the patch (replace the path with your actual DerivedData path)
sed -i.bak '33s/ABSL_CONST_INIT //' ~/Library/Developer/Xcode/DerivedData/MoniCrop-*/SourcePackages/checkouts/firebase-ios-sdk/Firestore/Source/API/FIRFirestoreSettings.mm
```

**Important Notes**:

- This patch is **temporary** and will be lost if you:
  - Clean the build folder (Product → Clean Build Folder)
  - Update Swift packages
  - Delete DerivedData
- You'll need to re-apply the patch if any of the above occur
- **Permanent solution**: Update Firebase SDK to version 10.x or 11.x (compatible with Xcode 26)
  - Requires updating `Package.swift` or `Package.resolved`
  - May require code changes for API compatibility

### Building the Project

1. Open `MoniCrop.xcodeproj` in Xcode
2. Ensure `GoogleService-Info.plist` and `Config.swift` are added to the project
3. Select your target device or simulator (iOS 16.1+)
4. Build and run (⌘R)
5. If build fails with Firebase error, apply the workaround above

## Project Structure

- **Models/**: Data models (Items)
- **Views/**: SwiftUI views for UI
  - Graph views: moisture, temperature, nitrogen, pH, phosphorus, potassium, conductivity, distance
  - Auth views: SignIn, SignUp, ForgotPassword
  - Main views: Home, Landing, Account, Customer, etc.
- **ViewModels/**: View models for data management
- **Assets.xcassets/**: Image assets (fruit icons, app logo)

## Features

- Firebase Authentication (email/password)
- Firestore database integration for soil data and user management
- Real-time sensor data visualization with labeled graphs
- Plant monitoring by fruit type and plant ID
- Account management
- Telegram bot integration for notifications

## Related Projects

This website is part of the **MoniCrop Smart Crop Monitoring System**:

- **[MoniCrop Hardware](https://github.com/emansarahafi/MoniCropHardware)** - IoT sensors and hardware components
- **[MoniCrop Website](https://github.com/emansarahafi/MoniCropWebsite)** - Functional Website

## Citation

If you use this work, please cite:

```bibtex
@article{Afi2023,
  author = "Eman Sarah Afi",
  title = "{Development of a Smart Crop Monitoring System}",
  year = "2023",
  month = "10",
  url = "https://aubh.figshare.com/articles/thesis/_b_Development_of_a_Smart_Crop_Monitoring_System_b_/30580751",
  doi = "10.58014/aubh.24314056.v2"
}
```

**Published thesis**: [Development of a Smart Crop Monitoring System](https://aubh.figshare.com/articles/thesis/_b_Development_of_a_Smart_Crop_Monitoring_System_b_/30580751) (DOI: 10.58014/aubh.24314056.v2)
