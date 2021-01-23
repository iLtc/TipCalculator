//
//  ContentView.swift
//  Shared
//
//  Created by Alan Luo on 1/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount: Double?
    @State private var tip: Double? = 0.0
    @State private var totalString = "$0.00"
    @State private var percentage: Double = 0.15
    
    var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        let amountValueBinding = Binding<Double?>(get: {
            amount
        }, set: {
            amount = $0
            
            if let amount = $0 {
                tip = amount * percentage
                totalString = String(format: "$%.2f", amount + (tip ?? 0))
            }
        })
        
        let tipValueBinding = Binding<Double?>(get: {
            tip
        }, set: {
            tip = $0
            
            if let tip = $0 {
                totalString = String(format: "$%.2f", (amount ?? 0) + tip)
                
                if let amount = amount, amount != 0 {
                    percentage = tip / amount
                }
            }
        })
        
        let percentageValueBinding = Binding<Double>(get: {
            percentage
        }, set: {
            percentage = $0
            
            if let amount = amount {
                tip = amount * percentage
                totalString = String(format: "$%.2f", amount + (tip ?? 0))
            }
        })
        
        GroupBox() {
            VStack {
                HStack {
                    Text("Amount:")
                    CurrencyTextField("", value: amountValueBinding, alwaysShowFractions: true)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Tip:")
                    CurrencyTextField("", value: tipValueBinding, alwaysShowFractions: true)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Total:")
                    Text(totalString)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                }
            }
        }.padding()
        
        GroupBox() {
            VStack {
                HStack {
                    Slider(value: percentageValueBinding, in: 0.05...0.30)
                    Text("\(percentage * 100, specifier: "%.0f")%")
                }
                HStack {
                    Button("Round Down", action: {
                        
                    })
                    Button("Round Up", action: {
                        
                    })
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
