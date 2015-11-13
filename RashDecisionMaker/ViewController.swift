import UIKit

private let CellReuseIdentifier = "ReceiptCell"

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewReceiptDelegate, ReceiptViewDelegate {
    @IBOutlet private weak var optionsList: UITableView!
    private var receiptList: ReceiptList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptList = ReceiptList()
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
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("ReceiptForm") as? ReceiptViewController {
            vc.receipt = receipt
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func beginCreateReceipt(receiptName: String) {
        var receipt = Receipt(title: receiptName, choices: [])
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
        cell.textLabel?.text = receipt.title
        cell.detailTextLabel?.text = receipt.desc
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        launchReceiptForm(receiptList.receipt(indexPath.row))
    }
}
