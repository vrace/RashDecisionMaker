import Foundation
import UIKit

class DefaultReceipt: Receipt {
    private(set) var title: String
    private(set) var choices: [Choice]
    var identity: Int = 0
    
    init(title: String) {
        self.title = title
        self.choices = []
    }
    
    init(dict: [String: String], components: [String]) {
        title = dict["title"] ?? ""
        choices = components
            .map(Choice.deserialise)
            .filter({ $0 != nil })
            .map({ $0! })
    }
    
    var type: ReceiptType {
        return .Default
    }
    
    var displayText: NSAttributedString {
        return NSAttributedString(string: title)
    }
    
    var displayDesc: String {
        var str = ""
        if !choices.isEmpty {
            str = choices[0].title
            
            for var i = 1; i < choices.count; i++ {
                str += ", \(choices[i].title)"
            }
        }
        return str
    }
    
    func random() -> Choice? {
        return choices.isEmpty ? nil : choice(Int(arc4random() % UInt32(numberOfChoices)))
    }
    
    func serialiseInfo() -> String {
        let dict = [
            "type": type.rawValue,
            "title": title
        ]
        return dictionaryToString(dict)
    }
    
    func serialise() -> String {
        var str = "\(serialiseInfo())\n%%\n"
        for c in choices {
            str += "\(c.serialise())\n%%\n"
        }
        return str
    }
    
    var numberOfChoices: Int {
        return count(choices)
    }
    
    func appendChoice(choice: Choice) {
        choices.append(choice)
    }
    
    func removeChoice(atIndex: Int) {
        choices.removeAtIndex(atIndex)
    }
    
    func choice(atIndex: Int) -> Choice {
        return choices[atIndex]
    }
}
