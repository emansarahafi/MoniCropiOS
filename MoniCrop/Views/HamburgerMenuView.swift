//
//  HamburgerMenuView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct HamburgerMenuView: View {
    @State var showMenu = false
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var usersVM: UsersViewModel
        
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
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

struct HamburgerMenuView_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerMenuView()
            .environmentObject(ApplicationData())
            .environmentObject(UsersViewModel())
    }
}
