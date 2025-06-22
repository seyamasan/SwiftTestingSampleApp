# SwiftTestingSampleApp

This repository is for experimenting with Swift testing.

Additionally, it includes some UI tests written using XCTest.

このリポジトリはSwift Testingを試すリポジトリです。

ついでにXCTestでUITestも書いています。

|Unit Testing & UI Unit Testing|
|-|
|<img width="456" alt="all_test" src="https://github.com/user-attachments/assets/410e675f-1316-4253-b776-ef5cd38faffe" />|

## App Description

This app calls GitHub’s Search REST API to search for repositories.

GitHubの検索用REST APIを呼び出して、リポジトリを検索できるアプリです。

|<img width="400" alt="SwiftTestingSampleApp_1" src="https://github.com/user-attachments/assets/47d2acb9-efd5-497c-9c09-48e12ed56617" />|<img width="400" alt="SwiftTestingSampleApp_2" src="https://github.com/user-attachments/assets/b97d0afd-5310-4c12-93e3-1953ed240578" />|<img width="400" alt="SwiftTestingSampleApp_3" src="https://github.com/user-attachments/assets/1e5a2e38-4218-4ba6-8094-5ebb1f9efb1e" />|
|-|-|-|

## Technology used

- SwiftUI

- Swift Testing

- XCTest

## Architecture

- MVVM

## Directory Structure

```
SwiftTestingSampleApp/
├── SwiftTestingSampleApp/            # Application
│   ├── Constant/                      # Centralized app-wide constants
│   ├── DI/                            # Dependency injection
│   ├── Data/                          # Data layer
│   ├── Error/                        # Custom error
│   ├── Model/                        # Data model
│   ├── UI/                          # UI screens
│   ├── ViewModel/                    # View logic
│   └── SwiftTestingSampleApp.swift  # Entry point
├── SwiftTestingSampleAppTests/      # Unit test
│   ├── Data/                        # Unit test of data layer
│   ├── Error/                        # Unit test of custom error
│   └── ViewModel/                    # Unit test of view logic
├── SwiftTestingSampleAppUITests/    # UI test
├── TestHelper/                      # Helper and fake data for testing
└── README.md                        # Project overview
```

## How to run the test

1. Run from the test file

Open the test target file in Xcode, then click the button shown to the left of the struct or class or test function to run it.

XCode上でテスト対象ファイルを開いてstruct、クラス、関数の左側に表示されているボタンをクリックする。

<img width="799" alt="test_file" src="https://github.com/user-attachments/assets/2d4d6f4f-036e-486b-81d0-dba801480dea" />

2. Run from the Test Navigator

Alternatively, run a specific test by selecting it from the Test Navigator.

Test Navigatorから任意のテストをクリックして実行する。

<img width="355" alt="test_navigator" src="https://github.com/user-attachments/assets/bedbdbda-f9eb-47bc-a95d-5e4aa644dd6f" />



