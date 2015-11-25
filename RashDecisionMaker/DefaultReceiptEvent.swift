import Foundation
import UIKit

class DefaultReceiptEvent: NSObject, ReceiptEventDelegate, UIAlertViewDelegate {
    var vc: ReceiptViewController?
    var receipt: Receipt?
    
    func receiptMakeDecision(vc: ReceiptViewController, receipt: Receipt) {
        self.vc = vc
        self.receipt = receipt
        
        if let choice = receipt.random() {
            UIAlertView(title: choice.title, message: nil, delegate: self, cancelButtonTitle: "OK").show()
        }
        else {
            UIAlertView(title: "请在加入至少一个可选项以后再摇", message: nil, delegate: self, cancelButtonTitle: "OK").show()
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        vc?.delegate = nil
        vc?.navigationController?.popViewControllerAnimated(true)
    }
}
