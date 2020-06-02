//
//  ContentView.swift
//  CurrencyApp
//
//  Created by Vova on 01.06.2020.
//  Copyright © 2020 ChernykhVladimir. All rights reserved.
//

import SwiftUI
import Combine
import UIKit


struct ContentView: View {
    @State private var selection = 0
    @State var base_currency: String = "USD"
    @State var currency_list: [String] = ["RUB", "USD", "EUR", "GBP", "CNY"]
    @State var amount = ""
    @State var data: [String: Double] = [:]
    @State var settingsShow = false
    @State var update_date = ""
    @State var keyboard = true
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("1 \(CurrencyInfo[base_currency]!["symbol"] as! String)", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                
                Picker("", selection: $base_currency) {
                    ForEach(0..<self.currency_list.count, id: \.self) { i in
                        Text(self.currency_list[i]).tag(self.currency_list[i])
                    }
                }
                .onReceive(Just(base_currency)) { new_val in
                    Api().getRates(base_currency: self.base_currency) { (temp) in
                        (self.data, self.update_date) = temp
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List(Array(data.keys).sorted(), id: \.self) { key in
                    NavigationLink(destination:
                        CurrencyExtendedCell(amount: self.$amount,
                                             name: key,
                                             base: self.base_currency,
                                             rate: self.data[key]!,
                                             date: self.update_date))
                    {
                        CurrencyCell(amount: self.$amount,
                                     name: key,
                                     rate: self.data[key]!)
                    }}
                
                
                Spacer()
            }
                
                
            .navigationBarTitle("Converter")
            .navigationBarItems(trailing:
                NavigationLink(destination:
                    Settings(list: self.$currency_list, keyboard: self.$keyboard)
                ) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 25.0, height: 25.0)
                    
                }
            )
            
        }
        .onTapGesture(count: 2) {
            if self.keyboard {
                UIApplication.shared.keyWindow?.endEditing(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
