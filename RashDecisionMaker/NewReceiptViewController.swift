import Foundation
import UIKit

protocol NewReceiptDelegate: class {
    func beginCreateReceipt(receiptName: String)
}

class NewReceiptViewController: UIViewController {
    @IBOutlet weak var receiptName: UITextField!
    weak var delegate: NewReceiptDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptName.becomeFirstResponder()
    }
    
    @IBAction func doneTapped() {
        if !receiptName.text.isEmpty {
            navigationController?.dismissViewControllerAnimated(true,
                completion: {
                    delegate?.beginCreateReceipt(receiptName.text)
            })
        }
    }
}
