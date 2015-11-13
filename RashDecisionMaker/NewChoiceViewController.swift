import Foundation
import UIKit

protocol NewChoiceDelegate: class {
    func choiceCreated(Choice)
}

class NewChoiceViewController: UIViewController {
    weak var delegate: NewChoiceDelegate?
    @IBOutlet weak var choiceName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choiceName.becomeFirstResponder()
    }
    
    @IBAction func doneTapped() {
        if !choiceName.text.isEmpty {
            let choice = Choice(title: choiceName.text)
            navigationController?.dismissViewControllerAnimated(true,
                completion: {
                    delegate?.choiceCreated(choice)
            })
        }
    }
}
