import UIKit

class ViewController
: UIViewController
, UITableViewDataSource
, UITableViewDelegate
, ReceiptListDelegate
{
    @IBOutlet private weak var optionsList: UITableView!
    
    private var receiptList: ReceiptList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptList = ReceiptList(delegate: self)
        receiptList.load()
    }
    
    @IBAction func editButtonTapped() {
        // just for fun
        receiptList.load()
    }
    
    @IBAction func addButtonTapped() {
        // just for fun
        
        var r = Receipt()
        r.title = "Haha"
        receiptList.append(r)
    }
    
    func receiptListUpdated(_: ReceiptList) {
        optionsList.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptList.numberOfReceipts
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let receipt = receiptList.receipt(indexPath.row)
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = receipt.title
        cell.detailTextLabel?.text = receipt.desc
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
