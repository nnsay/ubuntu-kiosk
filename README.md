### Kiosk Machine

This repository providers a way to change the Ubuntu Desktop OS to a kiosk model. But the kiosk model is not the OS kiosk model, it just change the OS UI and disable many feature in order to user just only can access your application(eg: appimage) which is deploied on the machine. 

Note:
- `优脑银河` and `Neural Galaxy` is a compony name, do not remember to change it in the `build_kiosk.sh` with yours
- `image` folder picture come from my compony, do not remember to replace them in the `image` folder pictures with yours

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

Firstly, we need a flash disk, create a `worksapce` folder on the flash disk for kiosk files. The `workspace` files look like this repository, the only different is the `app` folder, you should put the your application at here.

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

Prepare a machine which has the Ubuntu Desktop OS. In my testing, the OS is ubuntu 18.04.3 chinese minimal installation. After the machine is ok we can use the above flash disk to change the OS to kisok.

- install ubuntu 18.04.3 desktop minimal os in target machine
- create a user(not root) for kiosk, for example
  - username: ngiq
  - password:  123456
- login the target machine with above identity
- plug flash disk into target machine
- enter the target machine `workspace` folder and execute the script
  ```
  cd workspace
  ./build_kiosk.sh
  ```