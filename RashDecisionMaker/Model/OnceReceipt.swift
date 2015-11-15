import Foundation
import UIKit

class OnceReceipt: DefaultReceipt {
    override var type: ReceiptType {
        return .Once
    }
    
    override var displayText: NSAttributedString {
        var str = NSMutableAttributedString(string: "[摇后即焚] ",
            attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
        str.appendAttributedString(super.displayText)
        return str
    }
}
