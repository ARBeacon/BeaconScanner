#define DEVICE_NAME "ESP32"

#define BEACON_UUID "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"
#define BEACON_MAJOR 02
#define BEACON_MINOR 03
#define BEACON_MEASURED_POWER 0xc5

#include <BLEDevice.h>
#include <BLEBeacon.h>
#include <BLEServer.h>

BLEServer* pServer;

class aServerCallbacks : public BLEServerCallbacks {
  void restart_advertisement(BLEServer* pServer){
    BLEAdvertising* pAdvertising;
    pAdvertising = pServer->getAdvertising();
    pAdvertising->start();
  }
  void onConnect(BLEServer* pServer) {
    restart_advertisement(pServer);
  }
  void onDisconnect(BLEServer* pServer) {
    restart_advertisement(pServer);
  }
};

void setup_iBeacon() {
  BLEAdvertising* pAdvertising;
  pAdvertising = pServer->getAdvertising();
  pAdvertising->stop();

  BLEBeacon myBeacon;
  myBeacon.setManufacturerId(0x4c00);
  myBeacon.setMajor(BEACON_MAJOR);
  myBeacon.setMinor(BEACON_MINOR);
  myBeacon.setSignalPower(BEACON_MEASURED_POWER);
  myBeacon.setProximityUUID(BLEUUID(BEACON_UUID));

  BLEAdvertisementData advertisementData;
  advertisementData.setFlags(0x1A);
  advertisementData.setManufacturerData(myBeacon.getData());
  pAdvertising->setAdvertisementData(advertisementData);

  pAdvertising->start();
}

void setup() {
  BLEDevice::init(DEVICE_NAME);

  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new aServerCallbacks());

  setup_iBeacon();
}

void loop() {
}