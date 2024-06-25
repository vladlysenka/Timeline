// Created by Vlad Lysenka 25.06.2024

import SwiftUI
import Combine
import Observation

@Observable class Store {
    // MARK: - Calculator
    var value = "0"
    var num: Double = 0.0
    var operation: Operation = .none
    
    let buttons: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: Operation Enum
    enum Operation {
        case addition, subtract, multiply, divide, negative, percent, decimal, none
    }

    // MARK: Buttons Enum
    enum Buttons: String {
        case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
        case plus = "+", minus = "-", multiple = "×", divide = "÷", equal = "=", decimal = ",", percent = "%", negative = "+/-", clear = "AC"
        
        var background: Color {
            switch self {
            case .clear, .negative, .percent               : return Color.gray
            case .divide, .multiple, .minus, .plus, .equal : return Color.orange
            default                                        : return Color.gray.opacity(0.3)
            }
        }
        
        var color: Color {
            switch self {
            case .clear, .negative, .percent: return Color.black
            default                         : return Color.white
            }
        }
        
        func toOperation() -> Operation {
            switch self {
            case .plus:
                return .addition
            case .minus:
                return .subtract
            case .multiple:
                return .multiply
            case .divide:
                return .divide
            default:
                return .none
            }
        }
    }
        
    // MARK: Tap Button Method
    func didTap(button: Buttons) {
        switch button {
        case .plus, .minus, .multiple, .divide:
            operation = button.toOperation()
            num = Double(value) ?? 0
            value = "0"
        case .equal:
            if let currentValue = Double(value) {
                value = formatResult(performOperation(currentValue))
            }
        case .percent:
            if let currentValue = Double(value) {
                value = formatResult(currentValue / 100.0)
            }
        case .clear:
            value = "0"
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .negative:
            if let negativeValue = Double(value) {
                value = formatResult(-negativeValue)
            }
        default:
            if value == "0" {
                value = String(button.rawValue)
            } else {
                value += String(button.rawValue)
            }
        }
    }
    
    // MARK: Helper Culculate Method
    func performOperation(_ currentValue: Double) -> Double {
        switch operation {
        case .addition:
            return num + currentValue
        case .subtract:
            return num - currentValue
        case .multiply:
            return num * currentValue
        case .divide:
            return num / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: Remove Last "0" Method
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    // MARK: Size of Buttons Methods
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12.0
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero {
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12.0
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    
    // MARK: - Joke
    var text = ""
    var jokes: [String] = []
    var isJokeExists: Bool = false
    var isDownloading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        load()
    }
    
    func downloadRandomJoke() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        
        isDownloading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data )
            .decode(type: Joke.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isDownloading = false
                }
            } receiveValue: { joke in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.text = joke.value
                    self.checkJokeExist()
                }
            }
            .store(in: &cancellables)
    }
    
    func saveJoke() {
        jokes.append(text)
        checkJokeExist()
        save()
    }
    
    func removeJoke() {
        jokes.removeAll { $0 == text }
        checkJokeExist()
        save()
    }
    
    func deleteJoke(at indexSet: IndexSet) {
        jokes.remove(atOffsets: indexSet)
        checkJokeExist()
        save()
    }
    
    private func checkJokeExist() {
        isJokeExists = jokes.contains(text)
    }
    
    private func save() {
        UserDefaults.standard.setValue(jokes, forKey: "savedJokesKey")
    }
    
    private func load() {
        jokes = UserDefaults.standard.array(forKey: "savedJokesKey") as? [String] ?? []
    }
    
    struct Joke: Codable {
        let value: String
    }
}

