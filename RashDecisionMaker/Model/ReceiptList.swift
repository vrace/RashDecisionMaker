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
                    if let r = Receipt.deserialise("\(i + 1).txt") {
                        receipts.append(r)
                    }
                }
            }
        }
    }
    
    func save() {
        saveDocument(ReceiptListTxt, "count:\(receipts.count)")
        for var i = 0; i < receipts.count; i++ {
            receipts[i].serialise("\(i + 1).txt")
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
}
