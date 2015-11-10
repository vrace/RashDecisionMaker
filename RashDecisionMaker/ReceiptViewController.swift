import Foundation
import UIKit

private let CellReuseID = "ReceiptChoiceCell"

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var receipt: Receipt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = receipt.title
        becomeFirstResponder()
    }
    
    @IBAction func addButtonTapped() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipt.numberOfChoices
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier(CellReuseID) as? UITableViewCell) ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellReuseID)
        
        let choice = receipt.choice(indexPath.row)
        cell.textLabel?.text = choice.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake {
            let choice = receipt.random()
            UIAlertView(title: choice.title, message: nil, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
}
