# 💖 Flutter Dating App

A modern dating application built using Flutter and Firebase, featuring dynamic photo uploads, match filtering, and real-time profile management.


## 📦 Download APK

You can download the latest release APK from the link below:

🔗 **[Download Dating App APK](https://github.com/Gautam-Raaz/Dating_App/releases/download/v1.0.0/app-release.apk)**
---

## 🚀 Features

- Firebase Authentication (Phone/Email)
- Upload up to 8 profile pictures
- Delete images with index reassignment
- Intelligent image slot tracking (0–7)
- Like / Dislike logic
- Show only verified users (toggle)
- Firebase Storage + Firestore integration

---

## 📦 Tech Stack

- Flutter (Dart)
- Firebase (Auth, Firestore, Storage)

---

## 🧠 Image Management Logic

1. Delete images by extracting the index from Firebase Storage URLs and removing them.
2. Determine available image slots by comparing used indices with [0–7].
3. Upload new images into the first available slots and update their URLs.

---

## ⚙️ Setup Instructions

### Prerequisites

- Flutter SDK
- Firebase project created
- VS Code or Android Studio

### Steps

1. Clone the repository  
   Run:  
   git clone https://github.com/your-username/flutter-dating-app.git  
   cd flutter-dating-app

2. Install dependencies  
   Run:  
   flutter pub get

3. Configure Firebase  
   - Add google-services.json to android/app  
   - Add GoogleService-Info.plist to ios/Runner  
   - Enable Firebase Auth, Firestore, and Storage

4. Run the app  
   Run:  
   flutter run

---


## 📷 Screenshots

| Home Page | Filter User | Match Page |
|-----------|-------------|------------|
| ![Home](screenshots/home.jpeg) | ![Filter](screenshots/filter_user.jpeg) | ![Match](screenshots/match.jpeg)

---

## 🤝 Contributing

Pull requests are welcome. For major changes, open an issue to discuss your ideas first.

---

## 📄 License

Vistic Solution License © 2025 Gautam Raj

---

## 🙏 Acknowledgements

- Flutter
- Firebase
