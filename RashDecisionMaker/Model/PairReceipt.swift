import Foundation
import UIKit

class PairReceipt: ListReceipt {
    override var type: ReceiptType {
        return .Pair
    }
    
    override var displayText: NSAttributedString {
        var str = NSMutableAttributedString(string: "[Pair] ",
            attributes: [NSForegroundColorAttributeName: UIColor.orangeColor()])
        str.appendAttributedString(super.displayText)
        return str
    }
    
    override func randomList() -> [Choice] {
        var items = choices.map { $0 }
        for var i = 0; i < items.count; i++ {
            let t = Int(arc4random() % UInt32(items.count))
            let x = items[i]
            items[i] = items[t]
            items[t] = x
        }
        
        var arrange = [Choice]()
        for var i = 0; i < items.count / 2; i++ {
            let a = items[i * 2]
            let b = items[i * 2 + 1]
            arrange.append(Choice(title: "\(a.title) - \(b.title)"))
        }
        
        if items.count % 2 != 0 {
            arrange.append(Choice(title: "\(items.last!.title)"))
        }
        
        return arrange
    }
}
