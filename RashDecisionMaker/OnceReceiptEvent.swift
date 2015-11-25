import Foundation
import UIKit

class OnceReceiptEvent: DefaultReceiptEvent {
    override func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if receipt?.type == .Once {
            ReceiptList.instance.remove(receipt!)
            vc?.delegate?.receiptChanged(receipt!)
        }
        super.alertView(alertView, didDismissWithButtonIndex: buttonIndex)
    }
}
