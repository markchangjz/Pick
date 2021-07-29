import UIKit

class CandidateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pick(_ sender: UIBarButtonItem) {
        
        if let candidates = DataPersistence.candidates, candidates.count > 0 {
            performSegue(withIdentifier: "result", sender: nil)
        }
    }
    
    @IBAction func reloadView(_ unwindSegue: UIStoryboardSegue) {
        
        guard let addCandidateViewController = unwindSegue.source as? AddCandidateViewController else {
            return
        }

        if let text = addCandidateViewController.nameTextField.text, text.count > 0 {
            DataPersistence.add(candidate: text)
            tableView.reloadData()
        }
    }

}

extension CandidateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataPersistence.candidates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = DataPersistence.candidates?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DataPersistence.deleteCandidate(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
