//
//  BeaconsView.swift
//  BeaconScanner
//
//  Created by Maitree Hirunteeyakul on 20/10/2024.
//

import SwiftUI
import CoreLocation

struct BeaconsView: View {
    let beacons: [CLProximity: [CLBeacon]]
    var body: some View {
        ScrollView{
            VStack{
                ForEach(AllCLProximity, id: \.self){proximity in
                    HStack{
                        Text(CLProximityLabelPairs[proximity]!).bold()
                        Spacer()
                    }
                    let beaconsInProximity = beacons[proximity] ?? []
                    if beaconsInProximity.isEmpty{
                        HStack{
                            Spacer()
                            Text("Empty").italic().font(.footnote)
                            Spacer()
                        }
                    } else {
                        ForEach(beaconsInProximity, id: \.self){beacon in
                            BeaconView(beacon: beacon)
                        }
                    }
                    Divider().padding(.top, 8)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let beacons: [CLProximity: [CLBeacon]] = [
        .immediate: [MockBeacon(proximityUUID: UUID(uuidString: "49707bbc-33ac-4c6e-830a-dbfb567df422")!, major: 13, minor: 2, proximity: .immediate), MockBeacon(proximityUUID: UUID(uuidString: "bd0b95c7-5337-4ed2-bfe7-fac095df2211")!, major: 5, minor: 20, proximity: .immediate)],
        .near: [MockBeacon(proximityUUID: UUID(uuidString: "a0296e0a-308d-4d54-a147-afac97f1d644")!, major: 25, minor: 3, proximity: .near)],
        .far: [],
        .unknown: [MockBeacon(proximityUUID: UUID(uuidString: "5bdf43e6-ebc2-4d11-be34-f37e8dda1e08")!, major: 102, minor: 33, proximity: .unknown), MockBeacon(proximityUUID: UUID(uuidString: "13c90920-a36a-4b3c-b99d-d4a3034932c5")!, major: 29, minor: 78, proximity: .unknown), MockBeacon(proximityUUID: UUID(uuidString: "c8b6d240-2e6e-4092-9f62-6c68367acef0")!, major: 43, minor: 31, proximity: .unknown)]
    ]
    BeaconsView(beacons: beacons)
}
