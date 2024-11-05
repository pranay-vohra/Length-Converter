//
//  ContentView.swift
//  LengthConversion
//
//  Created by pranay vohra on 05/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNum:Double=0.0
    @State private var selectedInputUnit="meters"
    @State private var selectedOutputUnit="kilometer"
    @FocusState private var inputIsfocused:Bool
    
    let unitArr=["meters","kilometer","feet","yards","miles"]
    
    var calculatedNum:Double{
        let conversionFactors: [String: [String: Double]] = [
                "meters": ["kilometer": 0.001, "feet": 3.28084, "yards": 1.09361, "miles": 0.000621371, "meters": 1.0],
                "kilometer": ["meters": 1000, "feet": 3280.84, "yards": 1093.61, "miles": 0.621371, "kilometer": 1.0],
                "feet": ["meters": 1 / 3.28084, "kilometer": 1 / 3280.84, "yards": 0.33, "miles": 0.000189394, "feet": 1.0],
                "yards": ["meters": 1 / 1.09361, "kilometer": 1 / 1093.61, "feet": 3, "miles": 0.000568182, "yards": 1.0],
                "miles": ["meters": 1609.34, "kilometer": 1.60934, "feet": 5280, "yards": 1760, "miles": 1.0]
            ]

            let factor = conversionFactors[selectedInputUnit]?[selectedOutputUnit] ?? 1.0
            return inputNum * factor
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Input value?",value: $inputNum,format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsfocused)
                    
                    Picker("Input Unit",selection: $selectedInputUnit){
                        ForEach(unitArr,id: \.self){
                            Text("\($0)")
                        }
                    }
                    
                    
                    Picker("Output Unit",selection:$selectedOutputUnit){
                        ForEach(unitArr,id: \.self){
                            Text("\($0)")
                        }
                    }
                }
                Section("Output"){
                    Text(calculatedNum,format: .number)
                }
            }
            
            .navigationTitle("Length-Converter")
            .toolbar{
                if(inputIsfocused){
                    Button("Done"){
                        inputIsfocused=false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
