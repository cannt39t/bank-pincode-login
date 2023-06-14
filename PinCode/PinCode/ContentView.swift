//
//  ContentView.swift
//  PinCode
//
//  Created by Илья Казначеев on 14.06.2023.
//

import SwiftUI

struct IndicatorView: View {
    
    @Binding var color: Color
    @Binding var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: 25))
    }
    
    public func showStatus(_ text: String, _ color: Color) {
        self.text = text
        self.color = color
    }
}

struct ContentView: View {
    
    @State var pinCode: String = ""
    @State var errorMessage: String = "Wrong pincode"
    @State var indicatorColor: Color = .clear
    
    var body: some View {
        VStack {
            Spacer()
            Text("Enter the Pincode")
                .font(.system(size: 25))
                .padding()
            Spacer()
            IndicatorView(color: $indicatorColor, text: $errorMessage)
            Spacer()
            PinCodeView(pinCode: $pinCode)
                .padding()
            Spacer()
            KeyBoardView(pinCode: $pinCode, errorMessage: $errorMessage, indicatorColor: $indicatorColor)
                .padding()
            Spacer()
        }
    }
}

struct PinCodeView: View {
    
    @Binding var pinCode: String
    
    var body: some View {
        HStack {
            ForEach(0..<4) { i in
                Circle()
                    .strokeBorder(.black, lineWidth: 2)
                    .background(Circle().foregroundColor(i < pinCode.count ? .black : .clear))
                    .frame(width: 60, height: 60)
                    .padding(3)
            }
        }
    }
}

struct KeyBoardView: View {
    
    @Binding var pinCode: String
    @Binding var errorMessage: String
    @Binding var indicatorColor: Color
    @State var isEnable: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<4) { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(isEnable ? .white : Color.gray.opacity(0.1))
                            .onTapGesture {
                                if isEnable {
                                    if pinCode.count == 4 {
                                        pinCode = ""
                                    }
                                    pinCode.append("\(i)")
                                }
                            }
                        Text("\(i)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                    }
                }
            }
            
            HStack {
                ForEach(4..<7) { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(isEnable ? .white : Color.gray.opacity(0.1))
                            .onTapGesture {
                                if isEnable {
                                    if pinCode.count == 4 {
                                        pinCode = ""
                                    }
                                    pinCode.append("\(i)")
                                }
                            }
                        Text("\(i)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                    }
                }
            }
            
            HStack {
                ForEach(7..<10) { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(isEnable ? .white : Color.gray.opacity(0.1))
                            .onTapGesture {
                                if isEnable {
                                    if pinCode.count == 4 {
                                        pinCode = ""
                                    }
                                    pinCode.append("\(i)")
                                }
                            }
                        Text("\(i)")
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                    }
                }
            }
            
            HStack {
                ForEach(10..<13) { i in
                    ZStack {
                        Rectangle()
                            .frame(height: 70)
                            .foregroundColor(isEnable ? .white : Color.gray.opacity(0.1))
                            .onTapGesture {
                                if i == 10 {
                                    if isEnable {
                                        
                                    }
                                } else if i == 11 {
                                    if isEnable {
                                        if pinCode.count == 4 {
                                            pinCode = ""
                                        }
                                        pinCode.append("0")
                                    }
                                } else {
                                    if isEnable {
                                        if pinCode.count == 4 {
                                            pinCode = ""
                                        }
                                        if pinCode.count != 0 {
                                            pinCode.removeLast()
                                        }
                                    }
                                }
                            }
                        if i == 10 {
                            Image(systemName: "faceid")
                                .font(.system(size: 28))
                                .foregroundColor(.gray)
                        } else if i == 11 {
                            Text("0")
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                        } else {
                            Image(systemName: "delete.backward")
                                .font(.system(size: 28))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .onChange(of: pinCode) { newValue in
            if newValue.count == 4 {
                isEnable = false
                if pinCode == "1234" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        errorMessage = "Welcome"
                        indicatorColor = .green
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        errorMessage = "Wrong pincode"
                        indicatorColor = .red
                        isEnable = true
                    }
                }
            } else {
                indicatorColor = .clear
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
