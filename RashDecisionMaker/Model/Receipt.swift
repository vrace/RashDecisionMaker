import Foundation

class Receipt {
    var title: String!
    var choices = [Choice]()
    
    init() {
        title = "Test"
        
        choices.append(Choice())
    }
    
    var desc: String {
        return "The quick brown fox jumps over the lazy dog."
    }
    
    var numberOfChoices: Int {
        return count(choices)
    }
    
    func choice(atIndex: Int) -> Choice {
        return choices[atIndex]
    }
}
