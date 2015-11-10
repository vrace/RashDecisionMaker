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
    
    func random() -> Choice {
        // TODO: envolve this to achieve more reasonable result
        return choice(Int(arc4random() % UInt32(numberOfChoices)))
    }
}
