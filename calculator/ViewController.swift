//
//  ViewController.swift
//  calculator
//
//  Created by Ekaterina on 10.10.2024.
//

import UIKit


//отвечает за отображение
class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    lazy var viewModel = ViewModel(closure: { [weak self] text in
        
        self?.label.text = text
        
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //срабатывает когда пользователь нажал
    @IBAction func tapOne(_ sender: UIButton) {
        viewModel.tapNumber(.one)
    }
    
    @IBAction func tapTwo(_ sender: UIButton) {
        viewModel.tapNumber(.two)
    }
    
    @IBAction func tapThree(_ sender: UIButton) {
        viewModel.tapNumber(.three)
    }
    
    @IBAction func tapFour(_ sender: UIButton) {
        viewModel.tapNumber(.four)
    }
    
    @IBAction func tapFive(_ sender: UIButton) {
        viewModel.tapNumber(.five)
    }
    
    @IBAction func tapSix(_ sender: UIButton) {
        viewModel.tapNumber(.six)
    }
    
    @IBAction func tapSeven(_ sender: UIButton) {
        viewModel.tapNumber(.seven)
    }
    
    @IBAction func tapEight(_ sender: UIButton) {
        viewModel.tapNumber(.eight)
    }
    
    @IBAction func tapNine(_ sender: UIButton) {
        viewModel.tapNumber(.nine)
    }
    
    @IBAction func tapZero(_ sender: UIButton) {
        viewModel.tapNumber(.zero)
    }
    
    @IBAction func tapDivide(_ sender: UIButton) {
        viewModel.setOperation(.divide)
    }
    
    @IBAction func tapMultiply(_ sender: UIButton) {
        viewModel.setOperation(.multiply)
    }
    
    @IBAction func tapMinus(_ sender: UIButton) {
        viewModel.setOperation(.minus)
    }
    
    @IBAction func tapPlus(_ sender: UIButton) {
        viewModel.setOperation(.plus)
    }
    
    @IBAction func tapDecimal(_ sender: UIButton) {
        viewModel.tapDecimal()
    }
    
    @IBAction func tapEquals(_ sender: UIButton) {
        viewModel.calculateResult()
    }
    
    @IBAction func tapClear(_ sender: UIButton) {
        viewModel.clear()
    }
    
    @IBAction func tapToggleSign(_ sender: UIButton) {
        viewModel.toggleSign()
    }
    
    @IBAction func tapPercent(_ sender: UIButton) {
        viewModel.tapPercent()
    }

}

enum Buttons {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
}

enum Operation {
    case divide
    case multiply
    case plus
    case minus
    case none
}


//отвечает за логику
class ViewModel {

    var currentNumber: String = ""
    var firstNumber: Double = 0
    var operation: Operation = .none
    var decimalEntered: Bool = false
    
    var closure: (String) -> ()
    
    init(closure: @escaping (String) -> ()) {
        self.closure = closure
    }
    
    func clear() {
        currentNumber = ""
        firstNumber = 0
        operation = .none
        decimalEntered = false
        closure("0")
    }
    
    //проверка на целое число
    func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(result))
        } else {
            return String(result)
        }
    }
    
    func tapNumber(_ button: Buttons) {
        switch button {
        case .one:
            currentNumber.append("1")
        case .two:
            currentNumber.append("2")
        case .three:
            currentNumber.append("3")
        case .four:
            currentNumber.append("4")
        case .five:
            currentNumber.append("5")
        case .six:
            currentNumber.append("6")
        case .seven:
            currentNumber.append("7")
        case .eight:
            currentNumber.append("8")
        case .nine:
            currentNumber.append("9")
        case .zero:
            currentNumber.append("0")
        }
        
        closure(currentNumber)
    }
    
    func tapDecimal() {
        if !decimalEntered {
            if currentNumber.isEmpty {
                currentNumber = "0."
            } else {
                currentNumber.append(".")
            }
            decimalEntered = true
        }
        
        closure(currentNumber)
    }
    
    func setOperation(_ newOperation: Operation) {
        if !currentNumber.isEmpty {
            firstNumber = Double(currentNumber) ?? 0
            currentNumber = ""
            decimalEntered = false
        }
        operation = newOperation
    }
    
    func calculateResult() {
        guard let secondNumber = Double(currentNumber) else {
            return
        }
        
        var result: Double = 0
        
        switch operation {
        case .plus:
            result = firstNumber + secondNumber
        case .minus:
            result = firstNumber - secondNumber
        case .multiply:
            result = firstNumber * secondNumber
        case .divide:
            if secondNumber != 0 {
                result = firstNumber / secondNumber
            } else {
                closure("Ошибка")
                return
            }
        case .none:
            return
        }
    
        // Проверка на целое число
        currentNumber = formatResult(result)
    
        closure(currentNumber)
        operation = .none
        decimalEntered = false
    }
    
    func toggleSign() {
        if !currentNumber.isEmpty, let number = Double(currentNumber) {
            
            let toggledNumber = -number
            
            currentNumber = formatResult(toggledNumber)
            
            closure(currentNumber)
        }
    }

    func tapPercent() {
        if let number = Double(currentNumber) {
            
            let percentageValue = number / 100
            
            currentNumber = formatResult(percentageValue)
            
            closure(currentNumber)
        }
    }
}
