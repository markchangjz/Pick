import UIKit
import Firebase

class AddCandidateViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var addCandidateCompletion: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.becomeFirstResponder() // present keyboard
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        guard let name = nameTextField.text, name.count > 0 else { return }
        
        var candidates = DataPersistence.candidates ?? []
        candidates.append(name)
        DataPersistence.add(candidate: name)
                
        let docData: [String: Any] = [
            "names": candidates
        ]
                
        let db = Firestore.firestore()
        db.collection("pick").document("candidates").setData(docData) { error in
            if error == nil {
                self.dismiss(animated: true)
                self.addCandidateCompletion?()
            }
        }
    }
    
}

extension AddCandidateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder() // dismiss keyboard
        }
        return true
    }
}
