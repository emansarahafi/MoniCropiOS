//
//  Style.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

extension Color {
    static let accent = Color(red: 148/255, green: 178/255, blue: 2/255)
}

extension View {
    func primaryButtonStyle() -> some View {
        self.buttonStyle(.borderedProminent)
            .tint(.accent)
            .foregroundColor(.white)
    }

    func titleStyle() -> some View {
        self.font(.title)
            .fontWeight(.bold)
    }

    func headerStyle() -> some View {
        self.font(.headline)
            .fontWeight(.semibold)
    }

    func bodyStyle() -> some View {
        self.font(.body)
    }
}
