//
//  ViewDataView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI

struct ViewDataView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 148/255, green: 178/255, blue: 2/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor.black
    }

    var body: some View {
        VStack {
            Text("View Data")
                .foregroundColor(Color.accent)
                .titleStyle()
                .fontWeight(.bold)
            
            TabView {
                NitrogenView().tabItem({
                    Label("Nitrogen Level", systemImage: "n.circle")
                })
                PhosphorusView().tabItem({
                    Label("Phosphorus Level", systemImage: "p.circle")
                })
                PotassiumView().tabItem({
                    Label("Potassium Level", systemImage: "k.circle")
                })
                PHView().tabItem({
                    Label("pH Level", systemImage: "arrow.up.right")
                })
                ConductivityView().tabItem({
                    Label("Conductivity Level", systemImage: "arrow.up.forward.app")
                })
                MoistureView().tabItem({
                    Label("Moisture Level", systemImage: "drop.fill")
                })
                DistanceView().tabItem({
                    Label("Growth Speed Rate", systemImage: "speedometer")
                })
                TemperatureView().tabItem({
                    Label("Soil temperature", systemImage: "thermometer.high")
                })

            }.accentColor(.black)
        }
        .padding()
    }
}

struct ViewDataView_Previews: PreviewProvider {
    static var previews: some View {
        // Static mock of the tabs to avoid instantiating metric views that call Firebase
        VStack(spacing: 12) {
            Text("View Data")
                .titleStyle()
                .fontWeight(.bold)
            Text("Nitrogen | Phosphorus | Potassium | pH | Conductivity | Moisture | Distance | Temperature")
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
