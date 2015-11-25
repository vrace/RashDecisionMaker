import Foundation

func receiptFromFile(file: String) -> Receipt? {
    if let str = loadDocument(file) {
        var comps = str.componentsSeparatedByString("\n%%\n")
        if !comps.isEmpty {
            let dict = stringToDictionary(comps.first!)
            comps.removeAtIndex(0)
            
            if let receiptType = ReceiptType(rawValue: dict["type"] ?? "") {
                switch receiptType {
                case .Default:
                    return DefaultReceipt(dict: dict, components: comps)
                case .Once:
                    return OnceReceipt(dict: dict, components: comps)
                case .Pair:
                    return PairReceipt(dict: dict, components: comps)
                }
            }
        }
    }
    
    return nil
}
