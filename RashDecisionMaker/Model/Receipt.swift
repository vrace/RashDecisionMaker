import Foundation

class Receipt {
    private(set) var title: String!
    private var choices = [Choice]()
    
    init(title: String) {
        self.title = title
        
        choices.append(Choice(title: "老面馆"))
        choices.append(Choice(title: "兰州拉面"))
        choices.append(Choice(title: "兵哥豌杂"))
        choices.append(Choice(title: "重庆余桥面"))
        choices.append(Choice(title: "资格面"))
        choices.append(Choice(title: "宜宾燃面"))
        choices.append(Choice(title: "火锅冒菜"))
        choices.append(Choice(title: "三顾冒菜"))
        choices.append(Choice(title: "避风塘"))
        choices.append(Choice(title: "炒菜"))
        choices.append(Choice(title: "肥肠粉"))
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
    
    func choice(atIndex: Int) -> Choice {
        return choices[atIndex]
    }
    
    func random() -> Choice {
        // TODO: envolve this to achieve more reasonable result
        return choice(Int(arc4random() % UInt32(numberOfChoices)))
    }
    
    static func deserialise(filename: String) -> Receipt? {
        return nil
    }
}
