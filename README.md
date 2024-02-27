<p align="center">
  <img width="150"src="assets/icon/icon.png">
</p>

<h1 align="center"><strong>Technopedia</strong></h1>

<div align="center">
  <strong>
    Technopedia is a non-profit based project aimed at providing good quality technical content to its users. 
    This content ranges from a huge dictionary of technical terms to news and important reference links for tutorials and blogs.
  </strong>
</div>

<br>

<div align="center">
  <a href="https://nodejs.org/en/">
    <img src="https://img.shields.io/badge/Flutter-%3E%3D%201.17.2-blue.svg" alt="flutter version">
  </a>
  <a href="https://medium.com/@iamdeepakterse">
    <img src="https://img.shields.io/badge/Blog-medium-orange" alt="Chat">
  </a>
  <a href="https://www.linkedin.com/in/deepak-terse/">
    <img src="https://img.shields.io/badge/Connect-linkedin-blue" alt="connect">
  </a>
  <a href="https://github.com/deepak-terse"><img src="https://img.shields.io/badge/Author-deepak--terse-blue" alt="Author deepak-terse"></a>
</div>


## Prerequisites
*  Flutter
*  Dart
*  Android Basics (optional)

## Build Setup

### Clone the project
``` bash
git clone https://github.com/deepak-terse/nearme-app.git
cd nearme-app
```

### Install dependencies
``` bash
flutter pub get
```

### Copy the google auth credentials for the project 
- Copy the json from https://drive.google.com/file/d/1KvhV0n7FhjkinvpF7wHcsA_HtrHFkk8a
- Paste it at this location - `/lib/util/gsheets.dart` as instructed in that file

### Run the application
``` bash
flutter run
```

### Hot reload
Press r after flutter run

### Build a release version
``` bash
flutter clean
flutter build apk --target-platform=android-arm64
```


## References
*  https://flutter.dev/docs/get-started


Copyright (c) 2020-present, [deepak-terse](https://github.com/deepak-terse).
