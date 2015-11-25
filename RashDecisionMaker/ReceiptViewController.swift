import Foundation
import UIKit

private let CellReuseID = "ReceiptChoiceCell"

protocol ReceiptViewDelegate: class {
    func receiptChanged(Receipt)
}

protocol ReceiptEventDelegate: class {
    func receiptMakeDecision(vc: ReceiptViewController, receipt: Receipt)
}

class ReceiptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewChoiceDelegate {
    var receipt: DefaultReceipt!
    var delegate: ReceiptViewDelegate?
    var eventDelegate: ReceiptEventDelegate?
    @IBOutlet weak var choiceList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = receipt.title
        becomeFirstResponder()
    }
    
    @IBAction func addButtonTapped() {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("NewChoice") as? NewChoiceViewController {
            vc.delegate = self
            presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToReceiptView(segue: UIStoryboardSegue) {
        
    }
    
    func choiceCreated(choice: Choice) {
        receipt.appendChoice(choice)
        choiceList.reloadData()
        
        delegate?.receiptChanged(receipt)
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
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        receipt.removeChoice(indexPath.row)
        delegate?.receiptChanged(receipt)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == UIEventSubtype.MotionShake {
            eventDelegate?.receiptMakeDecision(self, receipt: receipt)
        }
    }
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        alertViewDismissed()
    }
    
    func alertViewDismissed() {
        if receipt.type == .Once {
            ReceiptList.instance.remove(receipt)
            delegate?.receiptChanged(receipt)
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
