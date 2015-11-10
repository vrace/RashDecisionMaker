import Foundation

func dictionaryToString(dict: [String: String]) -> String {
    var str = ""
    for key in dict.keys {
        str += "\(key):\(dict[key]!)\n"
    }
    return str
}

func stringToDictionary(str: String) -> [String: String] {
    var dict: [String: String] = [:]
    for comp in str.componentsSeparatedByString("\n") {
        let parts = comp.componentsSeparatedByString(":")
        if parts.count == 2 {
            dict[parts[0]] = parts[1]
        }
    }
    return dict
}
