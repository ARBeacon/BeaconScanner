//
//  BeaconManager.swift
//  BeaconScanner
//
//  Created by Maitree Hirunteeyakul on 17/10/2024.
//

import Foundation
import CoreLocation

let AllCLProximity: [CLProximity] = [.immediate, .near, .far, .unknown]
let CLProximityLabelPairs: [CLProximity: String] = [.immediate: "Immediate", .near: "Near", .far: "Far", .unknown: "Unknown"]

class BeaconManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager!
    private var beaconConstraints: [CLBeaconIdentityConstraint: [CLBeacon]]!
    @Published private(set) var beacons: [CLProximity: [CLBeacon]]!
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        beaconConstraints = [CLBeaconIdentityConstraint: [CLBeacon]]()
        beacons = [CLProximity: [CLBeacon]]()
    }
    
    func startMonitoringBeacon(uuidString: String) {
        guard let uuid = UUID(uuidString: uuidString) else { return }
        
        locationManager.requestWhenInUseAuthorization()
        
        let constraint = CLBeaconIdentityConstraint(uuid: uuid)
        beaconConstraints[constraint] = []
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: uuid.uuidString)
        locationManager.startMonitoring(for: beaconRegion)
        
        print("Start monitoring beacon with uuid: \(uuid)")
    }
}

extension BeaconManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as? CLBeaconRegion
        if state == .inside {
            // Start ranging when inside a region.
            manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        } else {
            // Stop ranging when not inside a region.
            manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        
        print("didRange: \(beacons.count) beacons, first: \(beacons.first?.uuid.uuidString ?? "nil"))")

        /*
         Beacons are categorized by proximity. A beacon can satisfy
         multiple constraints and can be displayed multiple times.
         */
        beaconConstraints[beaconConstraint] = beacons
        
        self.beacons.removeAll()
        
        var allBeacons = [CLBeacon]()
        
        for regionResult in beaconConstraints.values {
            allBeacons.append(contentsOf: regionResult)
        }
        
        for range in AllCLProximity {
            let proximityBeacons = allBeacons.filter { $0.proximity == range }
            if !proximityBeacons.isEmpty {
                self.beacons[range] = proximityBeacons
            }
        }
    }
}
