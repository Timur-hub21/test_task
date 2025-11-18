# Test task

**MadeInDream** — Made in Dream test task.

---

## Flutter & Dart versions

- **Flutter:** 3.32.0 (stable)  
- **Dart:** 3.8.0 (stable)  


---

## Code generation
### Build runner:
1. **Run build runner:**  
   Run `flutter packages pub run build_runner build --delete-conflicting-outputs` to generate code and automatically delete any conflicting outputs.

---

## Android builds

### APK
Собирает APK с timestamp. Старые APK удаляются автоматически.

Если скрипт только что скачан с Git, ему может не хватать прав на выполнение.  
Выполните один раз:
```bash
chmod +x build_apk.sh

./build_apk.sh debug

./build_apk.sh release

