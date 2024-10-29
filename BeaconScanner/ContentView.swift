//
//  ContentView.swift
//  BeaconScanner
//
//  Created by Maitree Hirunteeyakul on 17/10/2024.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var beaconManager = BeaconManager()
    let beaconUUID = "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA"
    var beacon: [CLProximity: [CLBeacon]] {beaconManager.beacons}
    
    var body: some View {
        NavigationView {
            BeaconsView(beacons: beacon)
                .onAppear {
                    beaconManager.startMonitoringBeacon(uuidString: beaconUUID)
                }
                .navigationTitle("iBeacon")
        }
    }
}

#Preview {
    ContentView()
}
