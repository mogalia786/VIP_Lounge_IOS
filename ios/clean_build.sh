#!/bin/bash

# Clean Flutter build
cd ..
flutter clean

# Remove iOS build folders
rm -rf ios/Flutter/App.framework
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec
rm -rf ios/Flutter/Generated.xcconfig
rm -rf ios/Flutter/app.flx
rm -rf ios/Flutter/app.zip
rm -rf ios/Flutter/flutter_assets/
rm -rf ios/Flutter/flutter_export_environment.sh
rm -rf ios/ServiceDefinitions.json
rm -rf ios/Runner/GeneratedPluginRegistrant.*

# Remove Pods folder and related files
rm -rf ios/Pods/
rm -rf ios/Podfile.lock
rm -rf ios/Runner.xcworkspace

# Install pods
cd ios
pod deintegrate
pod cache clean --all
pod install --repo-update

# Open Xcode workspace
echo "Build preparation complete. Opening Xcode workspace..."
open Runner.xcworkspace
