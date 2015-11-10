import Foundation
import UIKit

private let CellReuseID = "ReceiptChoiceCell"

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var receipt: Receipt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = receipt.title
    }
    
    @IBAction func addButtonTapped() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipt.numberOfChoices
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let choice = receipt.choice(indexPath.row)
        
        let cell = (tableView.dequeueReusableCellWithIdentifier(CellReuseID) as? UITableViewCell) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellReuseID)
        
        cell.textLabel?.text = choice.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}
