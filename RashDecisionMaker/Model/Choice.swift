import Foundation

class Choice {
    var title: String!
    
    init(title: String) {
        self.title = title
    }
    
    func serialise() -> String {
        return dictionaryToString([
            "title": title
        ])
    }
    
    static func deserialise(str: String) -> Choice? {
        let dict = stringToDictionary(str)
        if let t = dict["title"] {
            return Choice(title: t)
        }
        return nil
    }
}
