### Kiosk Machine

### 1. script brief
- build_kiosk.sh
  - support fullscreen
  - neural galaxy logo
    - lock screen
    - desktop background
  - forbidden
    - shortcut
    - shutcut key
    - system auto upgrade
    - switch user login

### 2. how to build kiosk machine
#### 2.1 make USB flash disk
the `workspace` folder look like this repo, the only different is the `app` folder, you should put the your application at here.
```
workspace
├── app
│   └── app.AppImage
├── build_kiosk.sh
├── image
│   ├── app-logo.png
│   ├── home_background.jpg
│   ├── lock_screen.jpg
│   └── ng_logo.png
```
The above file can be copy to USB.
#### 2.2 Setup kiosk OS
- install ubuntu 18.04.3 desktop minimal os in target machine
- plug USB drive into target machine
- enter the USB target machine workspace directory and build the kiosk with current login user but not root user
  ```
  cd workspace
  ./build_kiosk.sh
  ```

### 3. Note
- `优脑银河` and `Neural Galaxy` is a compony name, do not remember to change it in the `build_kiosk.sh` with yours
- `image` folder picture come from my compony, do not remember to replace them in the `build_kiosk.sh` with yours