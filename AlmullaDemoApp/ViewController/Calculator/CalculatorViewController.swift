//
//  CalculatorViewController.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

extension Double {
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
        
    }
}

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblThree: UILabel!
    
    enum Operators : String {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multiply = "*"
    }
    
    /*----------------------Variables----------------------*/
    var numbersArray : [(num : Double, sign : Bool)] = [(0,true)]
    var numbersStringArray : [String] = ["0"]
    var operatorsArray : [Operators] = []
    var inputText : String = "0"
    var numberExist : Bool = false
    var pointExist : Bool = false
    var operatorExist : Bool = false
    var currentSign : Bool = true
    var percentExist : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- ButtonClicks
    @IBAction func clearBtnCliked(_ sender: Any)
    {
        lblOne.text = "0"
        lblTwo.text?.removeAll()
        lblThree.text?.removeAll()
        numbersArray = [(0,true)]
        operatorsArray = []
        numbersStringArray = ["0"]
        inputText = "0"
        numberExist = false
        pointExist = false
        operatorExist = false
        currentSign = true
        percentExist = false
    }
    
    @IBAction func backSpaceBtnCliked(_ sender: Any)
    {
        
        
    }
    
    @IBAction func arthematicBtnCliked(_ sender: Any)
    {
        //don't put operator after negetive sign without number
        if !numberExist && !currentSign {
            return
        }
        
        //put ")" when number is negetive
        if !currentSign {
            inputText += ")"
        }
        
        //check if op exist
        if operatorExist {
            //we are going to replace last 3 chars
            inputText = String(inputText.dropLast(3))
            operatorsArray.removeLast()
        } else {
            operatorExist = true
            numbersStringArray.append("")
        }
        
        //reset variables
        numberExist = false
        pointExist = false
        currentSign = true
        percentExist = false
        
        //get number that clicked
        guard let inputString : String = (sender as AnyObject).titleLabel?.text else {return}
        
        //modify input
        inputText = " " + inputString + " "
        
        //set lable with new input
        lblTwo.text = inputText
        
        //find operator and add it to array
        guard let ops : Operators = Operators.init(rawValue: inputString) else {return}
        operatorsArray.append(ops)
    }
    
    @IBAction func numbersBtnCliked(_ sender: Any)
    {
        if percentExist {return}
        //get number that clicked
        guard let inputString : String = (sender as AnyObject).titleLabel?.text else {return}
        
        //check if it is a point
        if inputString == "." {
            if pointExist {
                return
            } else {
                pointExist = true
            }
        }
        
        //pop last number to modify it
        guard let numberString : String = numbersStringArray.removeLast() else {return}
        if numberExist {
            numbersArray.removeLast()
        }
        
        //modify number based on input
        let newNumberString : String
        if inputText == "0" && inputString != "." {
            newNumberString = inputString
            numbersArray.removeFirst()
        } else {
            newNumberString = numberString + inputString
        }
        
        //push back new value
        numbersStringArray.append(newNumberString)
        numbersArray.append((Double(String(newNumberString))! , currentSign))
        
        //change input based on new number
        inputText = inputText.prefix(inputText.count - numberString.count) + newNumberString
        
        //re calculate whole input
        operatorExist = false
        numberExist = true
        reCalculate()
    }
    
    @IBAction func equalToBtnCliked(_ sender: Any)
    {
        //if the last entered was operator and there wasn't any number after that
        if (operatorExist && !numberExist){
            operatorsArray.removeLast()
            reCalculate()
        }
        
        // if we have only one number
        if (numbersArray.count < 2){
            return
        }
        
        //show the last calculated result a the last result :D
        let result : String = lblThree.text ?? "0"
        
        //remove and clear
        lblThree.text?.removeAll()
        numbersArray = []
        operatorsArray = []
        numbersStringArray = []
        
        //set input with result
        inputText = result
        lblOne.text = result
        
        //add result as input to elements
        let number : Double = Double(result)!
        currentSign = number >= 0
        numberExist = true
        numbersArray.append((num: abs(number), sign: currentSign))
        let numbersString : String = currentSign ? result : "(-" + result.dropFirst()
        pointExist = numbersString.contains(".")
        numbersStringArray.append(numbersString)
    }
    
    /*----------------------Calculate Logic----------------------*/
    func reCalculate(){
        //set lable with new input
        lblOne.text = inputText
        
        //if we have 2 number in our list and we are sure that next number is entered then calculate result
        if (numbersArray.count > 1 && numberExist) || (percentExist && numberExist) {
            
            //clone arrays to calculate
            var numbersArrayTemp : [(num : Double, sign : Bool)] = numbersArray
            var operatorsArrayTemp : [Operators] = operatorsArray
            
            //search for * and / from left
            var index : Int = 0
            while (!operatorsArrayTemp.isEmpty && index < operatorsArrayTemp.count){
                if operatorsArrayTemp[index] == .multiply || operatorsArrayTemp[index] == .divide {
                    
                    //get number and operators from left
                    let currentOP : Operators = operatorsArrayTemp.remove(at: index)
                    let num1Tuple = numbersArrayTemp.remove(at: index)
                    let num2Tuple = numbersArrayTemp.remove(at: index)
                    let result : Double
                    
                    //fix number sign
                    let num1 : Double = num1Tuple.sign ? num1Tuple.num : -num1Tuple.num
                    let num2 : Double = num2Tuple.sign ? num2Tuple.num : -num2Tuple.num
                    
                    //lets calculate result
                    switch currentOP {
                    case .multiply : result = num1 * num2
                    case .divide : result = num1 / num2
                    default: return
                    }
                    
                    //fix double point
                    let resultString = String(result)
                    if let fixedResult = Double(resultString){
                        //push back result
                        numbersArrayTemp.insert((abs(result.rounded(toPlaces: 8)), fixedResult < 0 ? false : true) , at: index)
                        index -= 1
                    }
                }
                index += 1
            }
            
            //search for + and - from left
            index = 0
            while (!operatorsArrayTemp.isEmpty && index < operatorsArrayTemp.count){
                if operatorsArrayTemp[index] == .plus || operatorsArrayTemp[index] == .minus {
                    
                    //get number and operators from left
                    let currentOP : Operators = operatorsArrayTemp.remove(at: index)
                    let num1Tuple = numbersArrayTemp.remove(at: index)
                    let num2Tuple = numbersArrayTemp.remove(at: index)
                    let result : Double
                    
                    //fix number sign
                    let num1 : Double = num1Tuple.sign ? num1Tuple.num : -num1Tuple.num
                    let num2 : Double = num2Tuple.sign ? num2Tuple.num : -num2Tuple.num
                    
                    //lets calculate result
                    switch currentOP {
                    case .minus : result = num1 - num2
                    case .plus : result = num1 + num2
                    default: return
                    }
                    
                    //push back result
                    numbersArrayTemp.insert((abs(result.rounded(toPlaces: 8)), result < 0 ? false : true ), at: index)
                    index -= 1
                }
                index += 1
            }
            
            //set result
            let resultTuple = numbersArrayTemp.removeFirst()
            let result = resultTuple.sign ? resultTuple.num : -resultTuple.num
            var resultString = String(result)
            if resultString.contains(".") {
                resultString = String(resultString.split(separator: ".")[1]) == "0" ? String(resultString.dropLast(2)) : resultString
            }
            lblThree.text = resultString
        }
        
    }
    
    
    
    
}
