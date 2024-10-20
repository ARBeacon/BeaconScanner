//
//  BeaconView.swift
//  BeaconScanner
//
//  Created by Maitree Hirunteeyakul on 20/10/2024.
//

import SwiftUI
import CoreLocation


struct BeaconFieldKey: View {
    var text: String
    
    var body: some View {
        Text(text).font(.footnote)
    }
}

struct BeaconFieldValue: View {
    var text: String
    
    var body: some View {
        Text(text).font(.footnote).bold()
    }
}

struct BeaconView: View {
    let beacon: CLBeacon
    var body: some View {
        VStack{
            HStack{
                BeaconFieldKey(text: "UUID")
                Spacer()
                Text(beacon.uuid.uuidString).font(.caption).bold()
            }
            HStack{
                VStack{
                    BeaconFieldKey(text: "Major")
                    BeaconFieldValue(text: String(describing: beacon.major))
                }
                Divider().frame(width: 1, height: 30)
                VStack{
                    BeaconFieldKey(text: "Minor")
                    BeaconFieldValue(text: String(describing: beacon.minor))
                }
            }
        }.padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(8)
            .shadow(color: .gray, radius: 4)
    }
}

class MockBeacon: CLBeacon {
    private var customUUID: UUID
    private var customMajor: NSNumber
    private var customMinor: NSNumber
    private var customProximity: CLProximity
    
    init(proximityUUID: UUID, major: NSNumber, minor: NSNumber, proximity: CLProximity) {
        self.customUUID = proximityUUID
        self.customMajor = major
        self.customMinor = minor
        self.customProximity = proximity
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var uuid: UUID {
        return customUUID
    }
    
    override var major: NSNumber {
        return customMajor
    }
    
    override var minor: NSNumber {
        return customMinor
    }
    
    override var proximity: CLProximity {
        return customProximity
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundColor(.black)
        BeaconView(beacon: MockBeacon(proximityUUID: UUID(uuidString: "863b5c99-7cbc-4829-a400-503c7d0db502")!, major: 1, minor: 2, proximity: .near))
    }.ignoresSafeArea()
    
}
