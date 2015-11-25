import Foundation
import UIKit

private let ReuseID = "ResultCell"

class ListResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var items = [Choice]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier(ReuseID) as? UITableViewCell) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: ReuseID)
        
        let choice = items[indexPath.row]
        cell.textLabel?.text = choice.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}
