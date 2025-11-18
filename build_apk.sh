if [ -z "$1" ]; then
  echo "❌ Укажите тип сборки: ./build_apk.sh debug или ./build_apk.sh release"
  exit 1
fi

BUILD_TYPE=$1
APK_OUTPUT_DIR="build/app/outputs/flutter-apk"

find "$APK_OUTPUT_DIR" -name "MadeInDream_${BUILD_TYPE}_*.apk" -type f -delete

if [ "$BUILD_TYPE" = "release" ]; then
  FLUTTER_BUILD_FLAG="--release"
elif [ "$BUILD_TYPE" = "debug" ]; then
  FLUTTER_BUILD_FLAG="--debug"
else
  echo "❌ Unknown BUILD_TYPE: $BUILD_TYPE. Use 'debug' or 'release'."
  exit 1
fi

BUILD_ID=$(date +%s)

flutter build apk $FLUTTER_BUILD_FLAG

if [ $? -ne 0 ]; then
  echo "❌ Сборка завершилась с ошибкой"
  exit 1
fi

if [ "$BUILD_TYPE" = "release" ]; then
  APK_SOURCE_PATH="$APK_OUTPUT_DIR/app-release.apk"
else
  APK_SOURCE_PATH="$APK_OUTPUT_DIR/app-debug.apk"
fi

APK_DEST_PATH="$APK_OUTPUT_DIR/MadeInDream_${BUILD_TYPE}_${BUILD_ID}.apk"

mv "$APK_SOURCE_PATH" "$APK_DEST_PATH"

echo -e "\033[4m\033[32m✅ Сборка завершена, свежий APK: $APK_DEST_PATH\033[0m"
