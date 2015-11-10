import Foundation

func documentPath(file: String) -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory = paths.first! as! String
    return documentsDirectory.stringByAppendingPathComponent(file)
}

func saveDocument(file: String, data: String) {
    data.writeToFile(documentPath(file),
        atomically: false,
        encoding: NSUTF8StringEncoding,
        error: nil)
}

func loadDocument(file: String) -> String? {
    return String(contentsOfFile: documentPath(file), encoding: NSUTF8StringEncoding, error: nil)
}
