//
//  ReSecureTextFieldView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
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
    struct Wrapper: View {
        @State var value: String = ""
        var body: some View { ReSecureTextFieldView(text: $value).padding() }
    }
    static var previews: some View {
        Wrapper()
            .previewLayout(.sizeThatFits)
    }
}
