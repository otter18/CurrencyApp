//
//  CurrencyCell.swift
//  CurrencyApp
//
//  Created by Vova on 01.06.2020.
//  Copyright © 2020 ChernykhVladimir. All rights reserved.
//

import SwiftUI



struct CurrencyExtendedCell: View {
    @Binding var amount: String
    var name: String
    var base: String
    var rate: Double
    var date: String
    
    var body: some View {
        VStack {
            
            Text(CurrencyInfo[base]!["name"] as! String)
                .font(.title)
            
            HStack {
                TextField("1 \(CurrencyInfo[base]!["symbol_native"] as! String)", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                
                Text(CurrencyInfo[base]!["symbol_native"] as! String)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
            }
//
//            Image(systemName: "arrow.down.circle")
//                .font(.largeTitle)
            
            Text(CurrencyInfo[name]!["name"] as! String)
                .font(.title)
            
            HStack {
                
                Text("\((Double(self.amount) ?? 1) * rate, specifier: "%.\(CurrencyInfo[name]!["decimal_digits"] as! Int)f")")
                    .font(.title)
                
                Spacer()
                
                Text(CurrencyInfo[name]!["symbol_native"] as! String)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
            }
            Text("Exchange rate on \(self.date)")
                .padding(.top, 100)
            Spacer()
            
        }
        .padding()
    }
}



struct CurrencyCell: View {
    @Binding var amount: String
    var name: String
    var rate: Double
    
    var body: some View {
        HStack {
            Text(CurrencyInfo[name]!["name"] as! String)
            Spacer()
            Text("\((Double(self.amount) ?? 1) * rate, specifier: "%.\(CurrencyInfo[name]!["decimal_digits"] as! Int)f") \(CurrencyInfo[name]!["symbol_native"] as! String)")
        }
    }
}

struct CurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExtendedCell(amount: .constant("100"),
                             name: "USD",
                             base: "RUS",
                             rate: 0.001,
                             date: "2018-04-26")
            .padding()
    }
}
