import UIKit

enum Operation: String {
    case add = "+"
    case substract = "-"
    case multiply = "×"
    case divide = "/"
    
    func calculate(_ number1: Double, _ number2: Double) -> Double {
        switch self {
        case .add:
            return number1 + number2
        case .substract:
            return number1 - number2
        case .multiply:
            return number1 * number2
        case .divide:
            return number1 / number2
        }
    }
}

enum CalculationHistoryItem {
    case number(Double)
    case operation(Operation)
}


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var calculationHistory: [CalculationHistoryItem] = []

    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    
    // Считывает цифры
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else { return }
        
        if buttonText == "," && label.text?.contains(",") == true {
            return
        }
        
        if label.text == "0" {
            label.text = buttonText
        } else {
            label.text?.append(buttonText)
        }
    }
    
    // Считывает арифметическую операцию
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let labelText = label.text,
              let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
              else { return }
        
        guard let buttonText = sender.currentTitle,
              let buttonOperation = Operation(rawValue: buttonText) else { return }
        
        calculationHistory.append(.number(labelNumber))
        calculationHistory.append(.operation(buttonOperation))
        
        resetLabelText()
    }
    
    func resetLabelText() {
        label.text = "0"
    }
    
    @IBAction func clearButtonPressed() {
        calculationHistory.removeAll()
        
        resetLabelText()
    }
    
    
    @IBAction func calculateButtonPressed() {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetLabelText()
    }
}
