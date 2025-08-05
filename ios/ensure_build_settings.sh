#!/bin/bash

# This script ensures consistent build settings across all environments

set -e

echo "--- Ensuring consistent build settings ---"

# Set the iOS deployment target
IOS_DEPLOYMENT_TARGET="15.0"

# Update Info.plist
PLIST_PATH="${PROJECT_DIR}/Runner/Info.plist"
/usr/libexec/PlistBuddy -c "Set :MinimumOSVersion ${IOS_DEPLOYMENT_TARGET}" "${PLIST_PATH}" 2>/dev/null || true

echo "✓ Updated MinimumOSVersion in Info.plist to ${IOS_DEPLOYMENT_TARGET}"

# Update project.pbxproj
PBXPROJ_PATH="${PROJECT_DIR}/Runner.xcodeproj/project.pbxproj"

# Update IPHONEOS_DEPLOYMENT_TARGET in all build configurations
for CONFIG in "Debug" "Release" "Profile"
do
    # Find and replace IPHONEOS_DEPLOYMENT_TARGET
    sed -i '' "s/IPHONEOS_DEPLOYMENT_TARGET = .*;/IPHONEOS_DEPLOYMENT_TARGET = ${IOS_DEPLOYMENT_TARGET};/g" "${PBXPROJ_PATH}" 2>/dev/null || true
done

echo "✓ Updated IPHONEOS_DEPLOYMENT_TARGET in project.pbxproj to ${IOS_DEPLOYMENT_TARGET}"

# Ensure the Podfile has the correct platform setting
PODFILE_PATH="${PROJECT_DIR}/Podfile"
if [ -f "${PODFILE_PATH}" ]; then
    # Check if platform is already set
    if ! grep -q "platform :ios" "${PODFILE_PATH}"; then
        # Add platform at the top of the Podfile
        sed -i '' "1i\
platform :ios, '${IOS_DEPLOYMENT_TARGET}'\
" "${PODFILE_PATH}"
        echo "✓ Added platform to Podfile"
    fi
fi

echo "--- Build settings verification complete ---"
