# 🩺 AI Diabetes Management System

**An AI-powered mobile application for personalized diabetes self-management, nutrition analysis, and health monitoring.**

The AI Diabetes Management System is a Flutter-based mobile application designed to help users make more informed decisions about their daily health and nutrition. By combining artificial intelligence, food analysis, personalized meal planning, and health-data tracking, the application aims to simplify diabetes self-management through an accessible digital platform.

The project integrates Flutter and Dart for cross-platform mobile development, Firebase for backend services, and AI-powered APIs to provide intelligent nutrition-related insights.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Technology Stack](#-technology-stack)
- [Application Workflow](#-application-workflow)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation and Setup](#-installation-and-setup)
- [API Configuration](#-api-configuration)
- [Running the Application](#-running-the-application)
- [Security and Privacy](#-security-and-privacy)
- [Future Improvements](#-future-improvements)
- [Disclaimer](#-medical-disclaimer)
- [Author](#-author)

---

## 📖 Overview

Managing diabetes involves more than monitoring blood glucose levels. It also requires attention to nutrition, meal choices, physical activity, and daily lifestyle habits.

This project explores how mobile technology and artificial intelligence can support these activities in one application.

The system provides tools for analyzing food images, generating personalized meal plans, accessing an AI-powered health assistant, and maintaining relevant health information. User profile information and recent glucose readings can be used to personalize certain recommendations.

### Project Objectives

- Make nutrition information easier to understand.
- Support informed food choices through AI-assisted food analysis.
- Generate personalized meal-planning suggestions.
- Provide a convenient interface for recording and reviewing health information.
- Offer an interactive chatbot for general diabetes-related questions.
- Demonstrate the practical integration of Flutter, Firebase, and AI services in a healthcare-focused application.

---

## ✨ Key Features

### 1. 🤖 AI-Powered Health Chatbot

An interactive chatbot designed to answer general questions related to diabetes, nutrition, and healthy lifestyle practices.

**Capabilities include:**
- Conversational interaction with an AI model.
- General diabetes and nutrition information.
- Responses to user questions through the Groq API.
- A dedicated chatbot interface within the mobile application.

AI-generated information should be treated as general educational guidance rather than a medical diagnosis.

### 2. 🍎 Food Image Analysis

The application includes an AI-assisted food analysis workflow that accepts food images for analysis.

**Designed capabilities include:**
- Submitting a food image for AI analysis.
- Extracting structured food-analysis information.
- Enriching relevant nutrition information using the USDA FoodData Central API.
- Presenting food-related insights to support more informed meal choices.

The accuracy of food identification and nutritional estimates depends on image quality, available food data, and the AI model's response.

### 3. 🥗 Personalized Meal Planning

The system can generate meal-plan suggestions using user profile information and relevant recent glucose readings.

**Key capabilities include:**
- AI-generated meal-plan suggestions.
- Personalization based on available user information.
- Nutrition-oriented recommendations.
- Support for planning meals as part of a daily routine.

Generated plans are intended to support healthy planning and should not replace a dietitian's or clinician's advice.

### 4. 📊 Health and Glucose Tracking

The application incorporates health-monitoring functionality to help users record and review relevant information.

Potential uses include:
- Recording glucose readings.
- Reviewing available health information.
- Supporting awareness of glucose trends.
- Using recent readings as context for personalized features.

The available tracking features depend on the implementation and the data entered by the user.

### 5. 👤 User Authentication and Profiles

Firebase services support user authentication and associated application data.

The user-related functionality includes:
- User authentication through Firebase.
- Saving relevant profile information.
- Using profile data to personalize supported features.
- Integrating user information with health-related application workflows.

### 6. 📋 Health Reports and History

The project includes health-history functionality to help organize relevant information over time.

Where supported by the current implementation, stored records can help users review previous information and maintain continuity across sessions.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application development |
| Dart | Main programming language |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud-based data storage |
| Groq API | AI-powered chatbot and supported generation workflows |
| USDA FoodData Central API | Food and nutrition data enrichment |
| HTTP | Communication with external APIs |
| JSON | Structured data exchange and parsing |

The exact services used by each feature depend on the application's current configuration.

---

## 🔄 Application Workflow

The application's main workflows can be summarized as follows:

1. **User authentication:** The user signs in or creates an account.
2. **Profile setup:** Relevant profile information is collected and saved.
3. **Health-data entry:** The user records applicable health information, including glucose readings where supported.
4. **Food analysis:** The user submits a food image for AI-assisted analysis.
5. **Nutrition enrichment:** Relevant food information can be supplemented using USDA nutrition data.
6. **Personalized planning:** The system uses available profile information and recent glucose readings to generate meal suggestions.
7. **AI interaction:** The user can ask general health and nutrition questions through the chatbot.
8. **Data storage and review:** Supported information is stored and can be accessed through the application's history and reporting features.

---

## 📁 Project Structure

The project follows a feature-oriented Flutter structure.

```text
AI-Diabetes-Mgt-System/
│
├── lib/
│   ├── config/
│   │   └── api_keys.dart
│   │
│   ├── models/
│   │   ├── food_analysis.dart
│   │   ├── meal_plan.dart
│   │   └── user_profile.dart
│   │
│   ├── screens/
│   │   └── chatbot/
│   │       └── chatbot_screen.dart
│   │
│   ├── services/
│   │   ├── ai_service.dart
│   │   ├── auth_service.dart
│   │   └── user_service.dart
│   │
│   └── widgets/
│       └── meal_plan_widgets.dart
│
├── android/
├── ios/
├── web/
├── test/
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

*This is a representative structure. Retain the folders and files that actually exist in your repository and add any additional modules present in your project.*

### Architectural Responsibilities

- **Models:** Represent structured application data, including food analysis, meal plans, and user profiles.
- **Screens:** Provide the user interface for interacting with application features.
- **Services:** Handle authentication, user-related operations, AI requests, and external API communication.
- **Widgets:** Provide reusable interface components.
- **Configuration:** Centralizes API configuration and related application settings.

---

## ⚙️ Prerequisites

Before running the application, install or configure the following:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (normally included with Flutter)
- [Git](https://git-scm.com/downloads)
- Android Studio, VS Code, or another compatible development environment
- An Android emulator, iOS simulator on macOS, or compatible physical device
- A Firebase project configured for the platforms you intend to run
- API credentials for the external services required by the features you want to test

Verify your Flutter installation:

```bash
flutter doctor
```

---

## 🚀 Installation and Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/Sardar-Usmann/AI-Diabetes-Mgt-System.git
```

Navigate to the project directory:

```bash
cd AI-Diabetes-Mgt-System
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Configure Firebase

Create or select a project in the [Firebase Console](https://console.firebase.google.com/).

Configure Firebase Authentication and Cloud Firestore according to the application's implementation.

For FlutterFire projects, install the FlutterFire CLI if required and configure the application:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Follow the generated configuration and ensure that Firebase initialization in the application matches your project setup.

Enable the authentication providers used by the app and configure appropriate Firestore security rules before testing with real user data.

### Step 4: Configure API Credentials

Configure the required API credentials locally. See [API Configuration](#-api-configuration) below.

### Step 5: Verify the Environment

Check available devices:

```bash
flutter devices
```

Review the project's dependencies and configuration if any setup errors occur.

---

## 🔑 API Configuration

The application integrates with external services that require API credentials.

### Groq API

Used for supported AI-powered chatbot and generation features.

Obtain credentials from the [Groq Console](https://console.groq.com/).

### USDA FoodData Central API

Used to retrieve food and nutrition information where supported by the analysis workflow.

Obtain an API key from [USDA FoodData Central](https://fdc.nal.usda.gov/api-key-signup.html).

### Compile-Time Configuration

The project's API configuration uses Dart compile-time environment values. For example, the configuration can read values using `String.fromEnvironment`.

Run the application with locally supplied credentials:

```bash
flutter run \
  --dart-define=GROQ_API_KEY=YOUR_GROQ_API_KEY \
  --dart-define=USDA_API_KEY=YOUR_USDA_API_KEY
```

On Windows PowerShell, the same command can be entered on one line:

```powershell
flutter run --dart-define=GROQ_API_KEY=YOUR_GROQ_API_KEY --dart-define=USDA_API_KEY=YOUR_USDA_API_KEY
```

Replace the placeholders locally with valid credentials. Never commit actual API keys to source control.

**Important security note:** Compile-time values prevent credentials from being hardcoded in source files, but they do not make secrets secure in a distributed client application. For production deployments, route private API requests through a secured backend and protect credentials with server-side configuration.

---

## ▶️ Running the Application

After completing the setup:

```bash
flutter run
```

If the application requires the Groq and USDA API credentials, use the configured `--dart-define` command above.

To run static analysis:

```bash
flutter analyze
```

To execute the project's available automated tests:

```bash
flutter test
```

Successful execution of these commands depends on the completeness of the local configuration and the project's current implementation.

---

## 🔒 Security and Privacy

Because this application handles health-related information, security and privacy are important considerations.

- Do not commit API keys, passwords, tokens, or private configuration files.
- Use Firebase Authentication to manage access to authenticated functionality.
- Configure Firestore security rules to restrict access to authorized users.
- Avoid logging sensitive health information in production.
- Store only the personal and health information needed by the application.
- Use HTTPS for external API communication.
- Review third-party API terms and privacy policies before deploying the application.
- Consider a secure backend for AI requests that require private credentials.

The project should undergo appropriate security and privacy testing before being used with real patient data.

---

## 🔮 Future Improvements

Potential directions for further development include:

- **Advanced glucose analytics:** Interactive charts, summaries, and trend visualization.
- **Smarter meal recommendations:** More detailed personalization using dietary preferences and nutritional requirements.
- **Food recognition improvements:** Better food identification and portion-size estimation.
- **Medication reminders:** Optional reminders configured by the user and based on clinician-provided instructions.
- **Health report exports:** Downloadable summaries for discussion with healthcare professionals.
- **Wearable integration:** Importing supported readings from compatible devices.
- **Backend-based AI integration:** Moving private API credentials and sensitive AI operations to a secured backend.
- **Expanded automated testing:** Unit, integration, and UI tests for important workflows.
- **Accessibility improvements:** Better support for different screen sizes, readable text, and accessible navigation.

These are potential enhancements and should not be interpreted as features already implemented.

---

## ⚕️ Medical Disclaimer

This application is intended for educational and informational purposes and to support personal health management.

It is **not a substitute for professional medical advice, diagnosis, or treatment**. AI-generated responses, food analyses, nutritional estimates, and meal suggestions may be inaccurate or incomplete.

Users should consult qualified healthcare professionals before making significant changes to their diet, medication, insulin dosage, or treatment plan. The application should not be relied upon for emergency decisions or as a replacement for clinically validated glucose-monitoring equipment.

---

## 👨‍💻 Author

**Sardar Usmann**

GitHub: [@Sardar-Usmann](https://github.com/Sardar-Usmann)

Project repository: [AI Diabetes Management System](https://github.com/Sardar-Usmann/AI-Diabetes-Mgt-System)

---

## 📄 License

A license has not been specified here. If you intend to distribute the project as open source, add an appropriate `LICENSE` file and update this section to match the selected license.

---

*Built with Flutter, Dart, Firebase, and AI-powered services to explore the future of digital diabetes self-management.*
