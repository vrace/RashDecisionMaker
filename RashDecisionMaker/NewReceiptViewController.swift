import Foundation
import UIKit

protocol NewReceiptDelegate: class {
    func beginCreateReceipt(receiptType: ReceiptType, receiptName: String)
}

private let ReceiptTypeOptions = [
    (display: "标准", type: ReceiptType.Default),
    (display: "摇后即焚", type: ReceiptType.Once),
    (display: "Pair", type: ReceiptType.Pair)
]

class NewReceiptViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var receiptName: UITextField!
    @IBOutlet weak var receiptType: UIPickerView!
    weak var delegate: NewReceiptDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptName.becomeFirstResponder()
    }
    
    @IBAction func doneTapped() {
        if !receiptName.text.isEmpty {
            navigationController?.dismissViewControllerAnimated(true,
                completion: {
                    let type = ReceiptTypeOptions[self.receiptType.selectedRowInComponent(0)].type
                    self.delegate?.beginCreateReceipt(type, receiptName: self.receiptName.text)
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count(ReceiptTypeOptions)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return ReceiptTypeOptions[row].display
    }
}
