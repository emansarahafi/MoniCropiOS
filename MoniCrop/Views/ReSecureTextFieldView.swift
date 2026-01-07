//  ReSecureTextFieldView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct ReSecureTextFieldView: View {
    @State private var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Retype Password", text: $text)
            } else {
                TextField(text, text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash": "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}

struct ReSecureTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper("") { ReSecureTextFieldView(text: $0) }
    }
}
