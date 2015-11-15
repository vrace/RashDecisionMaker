import UIKit

private let CellReuseIdentifier = "ReceiptCell"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewReceiptDelegate, ReceiptViewDelegate {
    @IBOutlet private weak var optionsList: UITableView!
    private var receiptList: ReceiptList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptList = ReceiptList.instance
        receiptList.load()
    }
    
    @IBAction func addButtonTapped() {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("NewReceipt") as? NewReceiptViewController {
            vc.delegate = self
            presentViewController(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        
    }
    
    private func launchReceiptForm(receipt: Receipt) {
        switch receipt.type {
        case .Default:
            if let vc = storyboard?.instantiateViewControllerWithIdentifier("ReceiptForm") as? ReceiptViewController {
                vc.receipt = receipt as! DefaultReceipt
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            }
        case .Once:
            if let vc = storyboard?.instantiateViewControllerWithIdentifier("ReceiptForm") as? ReceiptViewController {
                vc.receipt = receipt as! DefaultReceipt
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func beginCreateReceipt(receiptType: ReceiptType, receiptName: String) {
        var receipt: Receipt!
        
        switch receiptType {
        case .Default:
            receipt = DefaultReceipt(title: receiptName)
        case .Once:
            receipt = OnceReceipt(title: receiptName)
        }
        
        receiptList.append(receipt)
        receiptList.save()
        launchReceiptForm(receipt)
        optionsList.reloadData()
    }
    
    func receiptChanged(_: Receipt) {
        receiptList.save()
        optionsList.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptList.numberOfReceipts
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier) as? UITableViewCell) ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CellReuseIdentifier)
        
        let receipt = receiptList.receipt(indexPath.row)
        cell.textLabel?.attributedText = receipt.displayText
        cell.detailTextLabel?.text = receipt.displayDesc
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        launchReceiptForm(receiptList.receipt(indexPath.row))
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        receiptList.remove(receiptList.receipt(indexPath.row))
        receiptList.save()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
}
