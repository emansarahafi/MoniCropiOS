//
//  DeleteView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/23.
//

import SwiftUI
// Deprecated wrapper for DisableDeleteView — prefer DisableDeleteView.swift
// Keeps compatibility until filenames are consolidated in the repo.

import SwiftUI

struct DeleteView: View {
    var body: some View { DisableDeleteView() }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
