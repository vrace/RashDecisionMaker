import Foundation
import UIKit

enum ReceiptType: String {
    case Default = ""
    case Once = "once"
}

protocol Receipt: class {
    var identity: Int { get set }
    var type: ReceiptType { get }
    var displayText: NSAttributedString { get }
    var displayDesc: String { get }
    func random() -> Choice?
    func serialise() -> String
}
