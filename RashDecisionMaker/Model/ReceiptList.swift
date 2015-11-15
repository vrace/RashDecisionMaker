import Foundation

private let ReceiptListTxt = "ReceiptList.txt"
private let TagCount = "count"

class ReceiptList {
    private var receipts = [Receipt]()
    
    func load() {
        receipts = []
        
        if let str = loadDocument(ReceiptListTxt) {
            let dict = stringToDictionary(str)
            if let count = dict[TagCount]?.toInt() {
                for var i = 0; i < count; i++ {
                    if let r = receiptFromFile("\(i + 1).txt") {
                        receipts.append(r)
                    }
                }
            }
        }
    }
    
    func save() {
        saveDocument(ReceiptListTxt, "count:\(receipts.count)")
        for var i = 0; i < receipts.count; i++ {
            saveDocument("\(i + 1).txt", receipts[i].serialise())
        }
    }
    
    var numberOfReceipts: Int {
        return receipts.count
    }
    
    func receipt(atIndex: Int) -> Receipt {
        return receipts[atIndex]
    }
    
    func append(receipt: Receipt) {
        receipts.append(receipt)
    }
    
    func remove(atIndex: Int) {
        receipts.removeAtIndex(atIndex)
    }
}
