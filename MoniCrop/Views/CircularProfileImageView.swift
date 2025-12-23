//
//  CircularProfileImageView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI

struct CircularProfileImageView: View {
    let imageState: Profile.ImageState

    var body: some View {
        Group {
            switch imageState {
            case .empty:
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            case .loading:
                ProgressView()
            case .loaded:
                // For placeholders we show the same system image.
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .shadow(radius: 4)
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(imageState: .empty)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
