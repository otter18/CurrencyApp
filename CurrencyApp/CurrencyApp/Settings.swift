//
//  Settings.swift
//  CurrencyApp
//
//  Created by Vova on 01.06.2020.
//  Copyright © 2020 ChernykhVladimir. All rights reserved.
//

import SwiftUI
import Combine

//                            .onAppear {
//                                Api().getCurrencyList { (temp) in
//                                    print(temp)
//                                    self.currency_list = temp
//                                }
//                            }



struct CurrencyListChange: View {
    @Binding var list: [String]
    @State var selected = Set<String>()
    @State var full_list: [String] = []
    @State var temp: String = ""
    
    var body: some View {
        VStack {
            Picker("", selection: $temp) {
                ForEach(0..<self.list.count, id: \.self) { i in
                    Text(self.list[i]).tag(self.list[i])
                }
            }
             .pickerStyle(SegmentedPickerStyle())
            Spacer()
            
            List(self.full_list, id: \.self, selection: $selected) { item in
                Text(item)
            }
            .onReceive(Just(selected)) { selection in
                if selection.count > 0 {
                    self.list = Array(selection).sorted()
                }
            }
            .onAppear {
                Api().getCurrencyList { (temp) in
                    self.full_list = (temp + ["EUR"]).sorted()
                }
                self.selected = Set(self.list.sorted())
            }
        }
        .navigationBarItems(trailing: EditButton())
    }
}

struct Settings: View {
    @Binding var list: [String]
    @Binding var keyboard: Bool
    
    var body: some View {
        VStack {
            Form {
                NavigationLink(destination:
                    CurrencyListChange(list: self.$list)
                ) {
                    Text("Currency picker")
                }
                Toggle("Double tap to hide keyboard", isOn: $keyboard)
            }
            Spacer()
            Spacer()
            
            Text("This is a demo app")
            Text("api.exchangeratesapi.io is used")
            Text("© Chernykh Vladimir, 2020")
            .padding(.bottom)
        }
        .navigationBarTitle("Settings")
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(list: .constant(["1", "2", "3"]), keyboard: .constant(false))
        
    }
}
