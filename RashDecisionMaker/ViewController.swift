import UIKit

private let CellReuseIdentifier = "ReceiptCell"

class ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private weak var optionsList: UITableView!
    private var receiptList: ReceiptList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptList = ReceiptList()
        receiptList.load()
    }
    
    @IBAction func editButtonTapped() {
        
    }
    
    @IBAction func addButtonTapped() {
        
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
        
        let receipt = receiptList.receipt(indexPath.row)
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("ReceiptForm") as? ReceiptViewController {
            vc.receipt = receipt
            showViewController(vc, sender: nil)
        }
    }
}
