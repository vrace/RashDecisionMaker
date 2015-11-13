import Foundation
import UIKit

protocol NewReceiptDelegate: class {
    func beginCreateReceipt(receiptName: String)
}

class NewReceiptViewController: UIViewController {
    @IBOutlet weak var receiptName: UITextField!
    var delegate: NewReceiptDelegate?
    
    @IBAction func doneTapped() {
        if !receiptName.text.isEmpty {
            navigationController?.dismissViewControllerAnimated(true,
                completion: {
                    delegate?.beginCreateReceipt(receiptName.text)
            })
        }
    }
}
