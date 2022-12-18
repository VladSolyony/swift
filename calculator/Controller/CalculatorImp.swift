//
//  CalculatorImp.swift
//  calculator
//
//  Created by Sergey on 10.11.2022.
//  Copyright © 2022 Илья Лошкарёв. All rights reserved.
//

import Foundation

class CalculatorImp: Calculator {
    var delegate: CalculatorDelegate?
    
    var inputLength: UInt
    var maxFraction: UInt
    
    
    required init(inputLength len: UInt, maxFraction frac: UInt) {
        self.inputLength = len
        self.maxFraction = frac
        hasPoint = false
        fractionDigits = 0
        
    }
    
    var result: Double?
    
    var operation: Operation?
    
    var input: Double?
    
    func addDigit(_ d: Int) {
        if !hasPoint {
            if log(input ?? 0) / log(10) < Double(inputLength - 1) {
                input = (input != nil ? input! * 10 : 0) + Double(d)
                delegate?.calculatorDidUpdateValue(self, with: input!, valuePrecision: 0)
            }
            else {
                delegate?.calculatorDidInputOverflow(self)
            }
        }
        else {
            if maxFraction > fractionDigits {
                fractionDigits += 1
                input = input! + (Double(d) / pow(10.0, Double(fractionDigits)))
                delegate?.calculatorDidUpdateValue(self, with: input!, valuePrecision: fractionDigits)
            }
            else {
                delegate?.calculatorDidInputOverflow(self)
            }
        }
    }
    
    func addPoint() {
        if !hasPoint {
            hasPoint = true
            delegate?.calculatorDidUpdateValue(self, with: input ?? 0, valuePrecision: fractionDigits)
        }
    }
    
    var hasPoint: Bool
    
    var fractionDigits: UInt
    
    func addOperation(_ op: Operation) {
        switch op {
        case .add:
            result = (result != nil ? result! : 0) + (input ?? 0)
            input = nil
            hasPoint = false
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        case .div:
            if result == 0 && (input == nil || input == 0) {
                delegate?.calculatorDidNotCompute(self, withError: "It is impossible to divide by 0")
            }
            else {
                if input != nil && result == nil {
                    result = input
                }
                else {
                    result = (result != nil ? result! : 0) / (input ?? 1)
                }
                input = nil
                hasPoint = false
                delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
            }
        case .mul:
            if result == nil && input == nil {
                result = 0
            }
            result = (result != nil ? result! : 1) * (input ?? 1)
            input = nil
            hasPoint = false
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        case .perc:
            input = (input ?? 0) / 100
            fractionDigits += 2
            delegate?.calculatorDidUpdateValue(self, with: input!, valuePrecision: fractionDigits)
        case .sign:
            input = -(input ?? 0)
            delegate?.calculatorDidUpdateValue(self, with: input!, valuePrecision: fractionDigits)
        case .sub:
            result = (result != nil ? result! : 2 * (input ?? 0)) - (input ?? 0)
            input = nil
            hasPoint = false
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        }
        operation = op
        resultTemp = nil
    }
    
    var resultTemp: Double?
    
    func compute() {
        switch operation {
        case .add:
            resultTemp = resultTemp ?? result ?? 0
            result = result != nil ? result! + (input ?? resultTemp!) : input
            hasPoint = false
            input = nil
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        case .div:
            resultTemp = resultTemp ?? result ?? 0
            if input == 0 || resultTemp == 0 {
                delegate?.calculatorDidNotCompute(self, withError: "It is impossible to divide by 0")
            }
            else {
                result = result != nil ? result! / (input ?? resultTemp!) : input
                hasPoint = false
                input = nil
                delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
            }
        case .mul:
            resultTemp = resultTemp ?? result ?? 0
            result = result != nil ? result! * (input ?? resultTemp!) : input
            hasPoint = false
            input = nil
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        case .none:
            delegate?.calculatorDidUpdateValue(self, with: input ?? 0, valuePrecision: fractionDigits)
        case .perc:
            fallthrough
        case .sign:
            delegate?.calculatorDidUpdateValue(self, with: input!, valuePrecision: fractionDigits)
        case .sub:
            resultTemp = resultTemp ?? result ?? 0
            result = result != nil ? result! - (input ?? resultTemp!) : input
            hasPoint = false
            input = nil
            delegate?.calculatorDidUpdateValue(self, with: result!, valuePrecision: 0)
        }
    }
    
    func clear() {
        input = 0
        hasPoint = false
        fractionDigits = 0
        delegate?.calculatorDidClear(self, withDefaultValue: 0, defaultPrecision: fractionDigits)
    }
    
    func reset() {
        result = nil
        clear()
    }
}
