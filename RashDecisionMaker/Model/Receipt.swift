import Foundation

class Receipt {
    private(set) var title: String!
    private var choices = [Choice]()
    
    init(title: String, choices: [Choice]) {
        self.title = title
        self.choices = choices
    }
    
    var desc: String {
        var str = ""
        if !choices.isEmpty {
            str = choices[0].title
            
            for var i = 1; i < choices.count; i++ {
                str += ", \(choices[i].title)"
            }
        }
        return str
    }
    
    var numberOfChoices: Int {
        return count(choices)
    }
    
    func appendChoice(choice: Choice) {
        choices.append(choice)
    }
    
    func choice(atIndex: Int) -> Choice {
        return choices[atIndex]
    }
    
    func random() -> Choice? {
        // TODO: envolve this to achieve more reasonable result
        return choices.isEmpty ? nil : choice(Int(arc4random() % UInt32(numberOfChoices)))
    }
    
    func serialise(filename: String) {
        var str = "title:\(title)\n%%\n"
        for c in choices {
            str += "\(c.serialise())\n%%\n"
        }
        
        saveDocument(filename, str)
    }
    
    static func deserialise(filename: String) -> Receipt? {
        var receipt: Receipt?
        
        if let str = loadDocument(filename) {
            var comps = str.componentsSeparatedByString("\n%%\n")
            if !comps.isEmpty {
                let dict = stringToDictionary(comps[0])
                if let title = dict["title"] {
                    comps.removeAtIndex(0)
                    let choices = comps.map(Choice.deserialise).filter({ $0 != nil }).map({ $0! })
                    receipt = Receipt(title: title, choices: choices)
                }
            }
        }
        
        return receipt
    }
}
