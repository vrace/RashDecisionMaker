import Foundation

protocol ReceiptListDelegate: class {
    func receiptListUpdated(ReceiptList)
}

class ReceiptList {
    private var receipts = [Receipt]()
    private weak var delegate: ReceiptListDelegate?
    
    init(delegate: ReceiptListDelegate?) {
        self.delegate = delegate
    }
    
    func load() {
        
        // just for fun for now
        let c = Int(3 + arc4random() % 8)
        
        receipts.removeAll(keepCapacity: false)
        
        for var i = 0; i < c; i++ {
            receipts.append(Receipt())
        }
        
        delegate?.receiptListUpdated(self)
    }
    
    func save() {
    }
    
    var numberOfReceipts: Int {
        return receipts.count
    }
    
    func receipt(atIndex: Int) -> Receipt {
        return receipts[atIndex]
    }
    
    func append(receipt: Receipt) {
        receipts.append(receipt)
        delegate?.receiptListUpdated(self)
    }
}
