import UIKit

class CandidateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        DataPersistence.add(candidate: "B2員工餐廳")
//        DataPersistence.add(candidate: "蘭陽水餃")
//        DataPersistence.add(candidate: "八方雲集")
//        DataPersistence.add(candidate: "麥當勞")
//        DataPersistence.add(candidate: "天祥豬腳飯")
//        DataPersistence.add(candidate: "小珍園")
//        DataPersistence.add(candidate: "下港吔羊肉")
//        DataPersistence.add(candidate: "鍋燒麵")
//        DataPersistence.add(candidate: "炸雞涼麵")
//        DataPersistence.add(candidate: "麵線傳奇")
//        DataPersistence.add(candidate: "低GI健康美學")
//        DataPersistence.add(candidate: "摩斯漢堡")
//        DataPersistence.add(candidate: "港式燒臘")
    }

    @IBAction func pick(_ sender: UIBarButtonItem) {
        
        if let candidates = DataPersistence.candidates, candidates.count > 0 {            
            let resultViewController = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
            
            // Pick a Restaurant randomly
            resultViewController.resultText = DataPersistence.candidates?.randomElement()
            navigationController?.pushViewController(resultViewController, animated: true)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ResultViewController
                destinationController.resultText = DataPersistence.candidates?[indexPath.row]
            }
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
