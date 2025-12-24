//
//  HamburgerMenuView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 12/23/25.
//

import SwiftUI
import Firebase

struct HamburgerMenuView: View {
    @State var showMenu = false

    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }

        return NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/1.25 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/1.25)
                            .transition(.move(edge: .leading))
                    }
                }
                    .gesture(drag)
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.black)
                                .accessibilityLabel("Menu")
                                .accessibilityIdentifier("hamburgerMenuButton")
                                .imageScale(.large)
                        }
                    }
                }
        }
    }
}

struct HamburgerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        // Static mock preview: main content + menu overlay
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    VStack(spacing: 50) {
                        Image("MoniCrop")
                            .accessibilityHidden(true)
                            .frame(width: 50, height: 50)
                        Text("Main Content")
                                .titleStyle()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)

                    MenuView()
                        .frame(width: geometry.size.width / 1.5)
                        .background(Color.white)
                }
            }
        }
        .previewLayout(.sizeThatFits)
        .frame(height: 400)
        .padding()
    }
}
