//
//  ViewDataView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

// Copied from ViewData.swift and renamed primary struct to match file name.
struct ViewDataView: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 148/255, green: 178/255, blue: 2/255, alpha: 1)
        UITabBar.appearance().tintColor = UIColor.black
    }

    var body: some View {
        VStack {
            Text("View Data")
                .foregroundColor(Color(red: 148/255, green: 178/255, blue: 2/255))
                .font(.title)
                .fontWeight(.bold)
            
            TabView {
                HumidityLevel().tabItem({
                    Label("Humidity Level", systemImage: "humidity.fill")
                })
                pHLevel().tabItem({
                    Label("pH Level", systemImage: "arrow.up.right")
                })
                SalinityLevel().tabItem({
                    Label("Salinity Level", systemImage: "arrow.up.forward.app")
                })
                WaterLevel().tabItem({
                    Label("Water Level", systemImage: "drop.fill")
                })
                GrowthSpeed().tabItem({
                    Label("Growth Speed", systemImage: "speedometer")
                })
                SoilTemperature().tabItem({
                    Label("Soil temperature", systemImage: "thermometer.high")
                })

            }.accentColor(.black)
        }
        .padding()
    }
}

struct ViewDataView_Previews: PreviewProvider {
    static var previews: some View {
        ViewDataView()
    }
}
