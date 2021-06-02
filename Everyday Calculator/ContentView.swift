//
//  ContentView.swift
//  Title: Everyday Calculator
//  Version: 0.5.3 (alpha)
//  Description: A basic calculator for iOS using Swift, Swift UI, and XCode 12.5. Not ready for real world use. Calculations could be inaccurate. Some functions do not work.
//
//  Created by Brad Schneider on 5/31/21.
//
//  0.5.1 was based on the iOS Academy YouTube video found at: https://www.youtube.com/watch?v=cMde7jhQlZI

import SwiftUI

// Defining the buttons on the calculator.  Using enumeration to list out each button and it's value. Using an enumeration also allows the code to itterate through the list.

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

// Defining the colors of the buttons.
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1))
        }
    }
}

// Defining the arithmetic operations.

enum Operation {
    case add, subtract, multiply, divide, none
}

// Start of the main UI of the app.

struct ContentView: View {

    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none

// Array of the buttons.
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal,],
    ]
    
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                
                // Results Display
                HStack {
                    Spacer()
                    Text(value)
//                      .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding()

                // Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(Float(self.value) ?? 0)
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(Float(self.value) ?? 0)
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(Float(self.value) ?? 0)
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(Float(self.value) ?? 0)
            }
            else if button == .equal {
                let runningValue = Float(self.runningNumber)
                let currentValue = Float(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
