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
                TextField("1 \(CurrencyInfo[base]!["symbol"] as! String)", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                
                Text(base)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
            }
//
//            Image(systemName: "arrow.down.circle")
//                .font(.largeTitle)
            
            Text(CurrencyInfo[name]!["name"] as! String)
                .font(.title)
            
            HStack {
                
                Text("\((Double(self.amount) ?? 1) * rate, specifier: "%.2f")")
                    .font(.title)
                
                Spacer()
                
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
            }
            Spacer()
            Text("Exchange rate on \(self.date)")
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
            Text("\((Double(self.amount) ?? 1) * rate, specifier: "%.2f") \(CurrencyInfo[name]!["symbol"] as! String)")
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
