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
        receipts.removeAll(keepCapacity: false)
        receipts.append(Receipt.deserialise("1.txt")!)
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
