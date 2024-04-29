//
//  ContentView.swift
//  ColorMix
//
//  Created by Medeline Agustine on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    static func randomizer() -> Double{
        return Double.random(in: 0..<1)
    }
    
    @State var redActual = randomizer()
    @State var greenActual = randomizer()
    @State var blueActual = randomizer()
    
    @State var redSlider: Double
    @State var greenSlider: Double
    @State var blueSlider: Double
    
    @State var showAlert = false
    
    func areColorsEqual() -> String{
        if(redActual==redSlider &&
           greenActual==greenSlider &&
           blueActual==blueSlider){
            return "The color match!"
        }else{
            return "The color not match, try again."
        }
    }
    
    var body: some View {
        VStack (spacing: 20){
            
            HStack{
                Circle().fill(Color(
                    red: redActual,
                    green: greenActual,
                    blue: blueActual)).padding()
                Circle().fill(Color(
                    red:redSlider,
                    green: greenSlider,
                    blue: blueSlider))
                    .padding()
            }
            
            Sliders(Value: $redSlider, color: .red, textColor: "🔴").accentColor(.red)
            Sliders(Value: $greenSlider, color: .green, textColor: "🟢").accentColor(.green)
            Sliders(Value: $blueSlider, color: .blue, textColor: "🔵").accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Button(action: {self.showAlert = true}) {
                Text("✅")}
            /*.alert(isPresented: $showAlert){
                Alert(title: Text("Result", message:Text(areColorsEqual())))
            }*/
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                .background(Color.orange)
                .cornerRadius(.infinity)
            
            /*Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("")
            }).padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                .background(Color(red: 134, green: 167, blue: 252))
                .cornerRadius(.infinity)
                .foregroundColor(.black)*/
            
            
        }
        
    }
}

#Preview {
    ContentView(redSlider: 0, greenSlider: 0, blueSlider: 0)
}

struct Sliders: View {
    @Binding var Value: Double
    var color: Color
    var textColor: String
    
    var body: some View {
        VStack{
            Text("\(textColor) (\(Int (Value*255)))")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Slider(value: $Value)
                .padding()
        }
    }
}
