//
//  CalculatorBrain.swift
//  Calc
//
//  Created by LiuScott on 15-4-2.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op :Printable {
        case Operand(Double)
        case UnaryOperation(String, Double ->Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        case Parameter(String)
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _) :
                    return symbol
                case .Parameter(let symbol):
                    return "\(symbol)"
                }
            }
        }
    }
    
    private var opStack = [Op]()
    private var knowOps = [String: Op]()
    init() {
        knowOps["×"] = Op.BinaryOperation("×", * )
        knowOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knowOps["+"] = Op.BinaryOperation("+", + )
        knowOps["-"] = Op.BinaryOperation("-") { $1 - $0 }
        knowOps["√"] = Op.UnaryOperation("√", sqrt )
        knowOps["Sin"] = Op.UnaryOperation("Sin", sin)
        knowOps["Cos"] = Op.UnaryOperation("Cos", cos)
        knowOps["X"] = Op.UnaryOperation("X", setX)
        knowOps["Y"] = Op.UnaryOperation("Y", setY)
        setParamValue("X", value: 0)
        setParamValue("Y", value: 0)
    }
    
    func setX(xValue: Double) -> Double {
        if (pushOperand("X") == 0) {
            setParamValue("X", value: xValue)
        }
        return pushOperand("X")!
    }
    func setY(yValue: Double) -> Double {
        if (pushOperand("Y") == 0) {
            setParamValue("Y", value: yValue)
        }
        
        return pushOperand("Y")!
    }
    
    func setParamValue(paramName: String, value : Double) {
        variableValues[paramName] = value
    }
    
    func returnPI(value: Double) -> Double {
        return M_PI
    }
    private func evaluate(ops :[Op]) -> (result: Double?, remainingOps: [Op] ) {
        if (!ops.isEmpty) {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand) :
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation) :
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    historyString = historyString.isEmpty ? "\(op.description)(\(operand))" : "\(op.description)(\(historyString))"
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation) :
                let oper1Evaluation = evaluate(remainingOps)
                if let operand1 = oper1Evaluation.result {
                    let oper2Evaluation = evaluate(oper1Evaluation.remainingOps)
                    if let operand2 = oper2Evaluation.result {
                        historyString = historyString.isEmpty ? "\(operand2) \(op.description) \(operand1)" : "\(operand2) \(op.description) (\(historyString))"
                        return (operation(operand1, operand2), oper2Evaluation.remainingOps)
                    } else {
                        historyString = "\(operand1) \(op.description) 0"
                        return (operation(operand1, 0), oper2Evaluation.remainingOps)
                    }
                }
            case .Parameter(let paramName):
                let valInDict = pushOperand(paramName)
                historyString = "\(paramName) is \(valInDict)"
                return (valInDict, remainingOps)
            }
        }
        return (nil, ops)
    }
    
    func clearStack() {
        opStack.removeAll(keepCapacity: false)
    }
    
    private var variableValues = Dictionary<String, Double>()
    
    func evaluate() -> Double? {
        historyString = ""
        let (result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }

    func pushOperand(symbol: String) -> Double? {
        return variableValues[symbol]
    }
    
    func pushOperand(oprand:Double) -> Double? {
        opStack.append(Op.Operand(oprand))
        return evaluate()
    }
    
    private var historyString : String = ""
    func getHistory() -> String? {
        return historyString
    }
    func performOperation(symbol:String) -> Double? {
        if let operation = knowOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}