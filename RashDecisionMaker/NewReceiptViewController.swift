import Foundation
import UIKit

protocol NewReceiptDelegate: class {
    func beginCreateReceipt(receiptType: ReceiptType, receiptName: String)
}

class NewReceiptViewController: UIViewController, UITextFieldDelegate {
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
                    delegate?.beginCreateReceipt(.Default, receiptName: receiptName.text)
            })
        }
    }
    
    @IBAction func cancelTapped() {
        receiptName.resignFirstResponder()
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
