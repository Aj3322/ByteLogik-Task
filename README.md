# Flutter Counter App

This Flutter application demonstrates a simple login system where users can register, log in, and track a counter value. The counter is personalized for each user, and its value is persisted using Firebase Realtime Database, even across sessions. This app uses Firebase Authentication for secure login/signup, and the state is managed using the GetX package.

## Features

1. **User Authentication**: Users can sign up or log in using their email and password via Firebase Authentication.
2. **Persistent Counter**: Each user has their own personalized counter value that persists in the Firebase Realtime Database and is accessible across logins.
3. **Increment Button**: Users can increment the counter, and the value updates in real-time.
4. **Real-Time Updates**: The counter is updated and displayed in real-time, ensuring a smooth user experience.

## Project Structure

```bash

lib/
├── app/
│   ├── data/
│   │   ├── model/
│   │   │   └── user_model.dart           # User model containing fields like counter, last login, email, etc.
│   │   ├── service/
│   │   │   ├── auth_service.dart         # Firebase authentication service
│   │   │   └── user_service.dart         # User service to handle Firebase database operations
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── bindings/
│   │   │   │   └── auth_binding.dart     # GetX bindings for Auth module
│   │   │   ├── controllers/
│   │   │   │   └── auth_controller.dart  # AuthController to handle login/signup logic
│   │   │   ├── views/
│   │   │   │   ├── login_view.dart       # UI for login screen
│   │   │   │   └── signup_view.dart      # UI for signup screen
│   │   │   ├── widgets/
│   │   │   │   ├── login_form.dart       # Login form widget with input fields and validation
│   │   │   │   └── signup_form.dart      # Signup form widget with input fields and validation
│   │   ├── home/
│   │   │   ├── bindings/
│   │   │   │   └── home_binding.dart     # GetX bindings for Home module
│   │   │   ├── controllers/
│   │   │   │   └── home_controller.dart  # HomeController to manage the counter logic
│   │   │   ├── views/
│   │   │   │   └── home_view.dart        # Home screen UI with the counter and increment button
│   ├── routes/
│   │   ├── app_pages.dart                # Defines app pages and routes
│   │   └── app_routes.dart               # Defines named routes for navigation
│   ├── utils/
│   │   ├── utils.dart                    # Utility functions and common widgets
│   │   └── firebase_options.dart         # Firebase configuration settings
├── main.dart                             # Application entry point

```

## Getting Started

### Prerequisites

1. **Flutter SDK**: Make sure you have Flutter installed. You can follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install) if it's not already set up.
2. **Firebase Setup**: Set up a Firebase project for your app. You'll need the Firebase project credentials (`google-services.json` for Android and `GoogleService-Info.plist` for iOS).

### Firebase Configuration

1. **Enable Firebase Authentication**:
   - Go to the Firebase Console.
   - Navigate to Authentication > Sign-in method.
   - Enable **Email/Password** authentication.
   
2. **Enable Realtime Database**:
   - Navigate to the Firebase Console.
   - Open the Realtime Database section.
   - Choose "Create Database" and start it in **test mode** for development purposes.

3. **Download Firebase Configuration Files**:
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) from Firebase and add them to the respective directories in your Flutter project.

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-repository/flutter-login-counter-app.git
cd flutter-login-counter-app
```

2. Install dependencies:

```bash
flutter pub get
```


3. Run the app:

```bash
flutter run
```

## Key Components

### 1. **Authentication (Firebase Authentication)**

- **Sign Up and Login**: Users can sign up or log in with their email and password. Firebase Authentication is used for secure and simple management of users.
  
- **AuthController**: Handles all Firebase-related authentication methods such as login, signup, password reset, and logout.

### 2. **User Data Persistence (Firebase Realtime Database)**

- Each user's counter value is stored under their unique user ID in Firebase Realtime Database.
- **UserProvider**: Contains methods to retrieve, update, and stream user data from Firebase.

### 3. **Counter Functionality**

- The home page displays the counter, which is user-specific and saved in the Firebase Realtime Database.
- The counter is updated in real-time when a user presses the "Increment" button.
  
### 4. **State Management with GetX**

- GetX is used for state management, dependency injection, and route management.
- **HomeController**: Manages the logic for counter increment and data fetching from Firebase.

### 5. **Error Handling**

- **FirebaseErrors**: Contains user-friendly messages mapped to Firebase error codes, ensuring that users see clear and understandable error messages (e.g., "Invalid email" instead of a technical error code).


## Firebase Error Handling

All Firebase-related errors (sign up, login, etc.) are mapped to user-friendly messages using the `firebase_errors.dart` file. Common Firebase errors include:

- **Email Already in Use**: This error is shown when the email address is already registered.
- **Weak Password**: If the password is too weak, the user will be notified.
- **Invalid Email**: The user will receive an alert if the email format is incorrect.

Example:
```dart
if (error.code == 'email-already-in-use') {
  Get.snackbar('Error', 'The email is already in use. Please choose another email.');
}
```

## Example Firebase Structure

The Firebase Realtime Database will look something like this:

```json
{
  "users": {
    "SyqQYWFgaVOkgydOd28JPXV83i03": {
      "accountStatus": "active",
      "counterValue": 15,
      "createdAt": "2024-09-28 04:42:12.495349",
      "email": "ajay.kumar.rs3322@gmail.com",
      "id": "SyqQYWFgaVOkgydOd28JPXV83i03",
      "lastCounterUpdate": "2024-09-28 11:49:17.729984",
      "lastLogin": "2024-09-28 11:49:42.856212",
      "lastPasswordChange": "2024-09-28 11:49:42.856212",
      "username": "Ajay Kumar"
    },
    "eGmlJUaSNfRXCjERv6hGxjpgrt63": {
      "accountStatus": "active",
      "counterValue": 7,
      "createdAt": "2024-09-28 04:20:05.343135",
      "email": "kunjsharma3322@gmail.com",
      "id": "eGmlJUaSNfRXCjERv6hGxjpgrt63",
      "lastCounterUpdate": "2024-09-28 04:35:04.929400",
      "lastLogin": "2024-09-28 04:37:57.638870",
      "lastPasswordChange": "2024-09-28 11:49:42.856212",
      "username": "Ajay Kumar "
    }
  }
}
```

## Dependencies

- **Firebase Authentication**: For user authentication
- **Firebase Realtime Database**: For persisting the user-specific counter
- **GetX**: For state management, dependency injection, and navigation
- **Flutter_svg**: For SVG image rendering

