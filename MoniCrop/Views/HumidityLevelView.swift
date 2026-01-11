//
//  HumidityLevelView.swift
//  MoniCrop
//
//  Created by Eman Sarah Afi on 1/7/26.
//

import SwiftUI

struct HumidityLevelView: View {

    @State var pickerSelection = 0
    @State var barValues : [[CGFloat]] =
        [
        [5,150,50,100,200,110,30,170,50],
        [200,110,30,170,50, 100,100,100,200],
        [10,20,50,100,120,90,180,200,40],
        [200,150,50,100,200,110,200,30,50],
        [10,200,50,30,200,110,30,40,50]
        ]
    var body: some View {
        ZStack{
            Color(.white).edgesIgnoringSafeArea(.all)

            VStack{
                Picker(selection: $pickerSelection, label: Text("Stats"))
                    {
                    Text("Mango").tag(0)
                    Text("Apple").tag(1)
                    Text("Carrot").tag(2)
                    Text("Strawberry").tag(3)
                    Text("Pear").tag(4)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)

                HStack(alignment: .center, spacing: 10)
                {
                    ForEach(barValues[pickerSelection], id: \.self){
                        data in
                        
                        BarView(value: data, cornerRadius: CGFloat(integerLiteral: 10*self.pickerSelection))
                    }
                }.padding(.top, 24).animation(.default)
            }
        }
    }

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 148/255, green: 178/255, blue: 2/255, alpha: 1)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}

struct HumidityLevelView_Previews: PreviewProvider {
    static var previews: some View {
        HumidityLevelView()
    }
}
