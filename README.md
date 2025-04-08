# BeaconScanner
Minimal iOS app for testing iBeacon observation with ESP32 beacons using Apple's CoreLocation framework.

## 📱 Features
- Real-time beacon proximity detection (Immediate/Near/Far)
- RSSI signal strength monitoring
- UUID/Major/Minor iBeacon Package Preview
- Multiple beacon simultaneous tracking

## 🚀 Quick Start

### Prerequisites
- **Hardware**:
  - iPhone (BLE-compatible)
  - ESP32 development board(s) (e.g., `ESP-WROOM-32`)
  - micro-usb cable for beacon programming
- **Software**:
  - Xcode 16+
  - Arduino IDE (for beacon programming)

### Hardware Setup
1. Download the [iBeacon broadcasting code](iBeaconArduino.ino)
2. Adjust Major and Minor of the iBeacon in the iBeacon broadcasting code
3. Upload iBeacon broadcasting code to ESP32 using Arduino IDE 

### App Setup
1. Clone the repo
```bash
git clone https://github.com/ARBeacon/BeaconScanner.git
```
2. Run the app:

open the project in Xcode and click "Run".

_Note: This README.md was refined with the assistance of [DeepSeek](https://www.deepseek.com)_
