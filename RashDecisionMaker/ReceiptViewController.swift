import Foundation
import UIKit

class ReceiptViewController: UIViewController {
    var receipt: Receipt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = receipt.title
    }
    
    @IBAction func addButtonTapped() {
        println("blablabla")
    }
}
