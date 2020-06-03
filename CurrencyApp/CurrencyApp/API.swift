//
//  API.swift
//  CurrencyApp
//
//  Created by Vova on 01.06.2020.
//  Copyright © 2020 ChernykhVladimir. All rights reserved.
//
import SwiftUI


struct Currency: Codable, Identifiable {
    let id = UUID()
    var rates: [String: Double]
    var base: String
    var date: String
}


class Api {
    func getRates(base_currency: String, complition: @escaping ((([String:Double], String)) -> ())) {
        guard
            let url = URL(string: "https://api.exchangeratesapi.io/latest?base=\(base_currency)")
        else { return }

        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let res = try! JSONDecoder().decode(Currency.self, from: data!)
            DispatchQueue.main.async {
                complition((res.rates, res.date))
            }
        }
        .resume()
    }
    
    func getCurrencyList(complition: @escaping (([String]) -> ())) {
        guard
            let url = URL(string: "https://api.exchangeratesapi.io/latest")
        else {
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let res = try! JSONDecoder().decode(Currency.self, from: data!)
            DispatchQueue.main.async {
                complition(Array(res.rates.keys))
            }
        }
        .resume()
    }
}
