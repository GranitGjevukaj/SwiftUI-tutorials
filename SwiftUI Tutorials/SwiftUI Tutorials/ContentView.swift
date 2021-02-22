//
//  ContentView.swift
//  SwiftUI Tutorials
//
//  Created by Granit Gjevukaj on 17.08.20.
//  Copyright © 2020 Hafen Apps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: States
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)

    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false

    // MARK: Compute Score
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }

    // MARK: Body
    var body: some View {
        NavigationView {
            VStack {

                // Color View
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        Text("Match this color:")
                    }
                    VStack {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("R: \(Int(rGuess * 255.0))"
                            + "  G: \(Int(gGuess * 255.0))"
                            + "  B: \(Int(bGuess * 255.0))")
                    }
                }

                // Hit me Button
                Button(action: {self.showAlert = true}) {
                    Text("Hit me!")
                }.alert(isPresented: $showAlert) { () -> Alert in
                    Alert(title: Text("Your Score"), message: Text(String(computeScore())))
                }.padding()

                // Sliders
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }.padding(.horizontal)
            }
        }
    }
}

struct ColorSlider: View {

    @Binding var value: Double
    var textColor: Color

    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
            Text("255").foregroundColor(textColor)
        }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
