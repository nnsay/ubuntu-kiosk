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
- plug USB drive into installation server
- Assuming installation server already has latest linux app image files, execute the below commands in installation server ngiq-infrastructure repo
  ```
  cd ngiq-infrastructure/kiosk
  ./build_usb.sh
  ```
  At end, the files in the USB drive looks like:
  ```
  navigator-workspace
  ├── app
  │   └── neuralgalaxy-desktop.AppImage
  ├── build_kiosk.sh
  ├── image
  │   ├── app-logo.png
  │   ├── home_background.jpg
  │   ├── lock_screen.jpg
  │   └── ng_logo.png
  └── tools
      └── config_server_ip.s
  ```
#### 2.2 Setup kiosk OS
- install ubuntu 18.04.3 desktop minimal os in navigator server
- plug USB drive into navigator server
- enter the USB navigator navigator workspace directory and build the kiosk with current login user but not root user
  ```
  cd navigator-workspace
  ./build_kiosk.sh
  ```