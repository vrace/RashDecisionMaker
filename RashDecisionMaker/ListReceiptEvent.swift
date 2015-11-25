import Foundation
import UIKit

class ListReceiptEvent: ReceiptEventDelegate {
    func receiptMakeDecision(vc: ReceiptViewController, receipt: Receipt) {
        if let resultVC = vc.storyboard?.instantiateViewControllerWithIdentifier("ListResultView") as? ListResultViewController {
            resultVC.items = (receipt as! ListReceipt).randomList()
            resultVC.navigationItem.hidesBackButton = true
            vc.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}
