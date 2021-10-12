import UIKit
import Firebase

class CandidatesViewController: UIViewController {
    
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
//
//        let docData: [String: Any] = [
//            "names": DataPersistence.candidates ?? []
//        ]
//
//        let db = Firestore.firestore()
//        db.collection("pick").document("candidates").setData(docData) { _ in
//        }
        
        
        let db = Firestore.firestore()
        db.collection("pick").addSnapshotListener { documentSnapshot, error in
            guard let snapshot = documentSnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                let names = diff.document.data()["names"] as? [String] ?? []

                DataPersistence.deleteAllCandidates()
                for name in names {
                    DataPersistence.add(candidate: name)
                }

                self.tableView.reloadData()
            }
        }

    }

    @IBAction func pick(_ sender: UIBarButtonItem) {
        
        if let candidates = DataPersistence.candidates, candidates.count > 0 {            
            let resultViewController = storyboard?.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
            
            // Pick a Restaurant randomly
            resultViewController.resultText = DataPersistence.candidates?.randomElement()
            navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ResultViewController
                destinationController.resultText = DataPersistence.candidates?[indexPath.row]
            }
        } else if segue.identifier == "addCandidate" {
            let addCandidateViewController = (segue.destination as! UINavigationController).viewControllers.first as! AddCandidateViewController
            addCandidateViewController.addCandidateCompletion = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension CandidatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataPersistence.candidates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = DataPersistence.candidates?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DataPersistence.deleteCandidate(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
                                
            let docData: [String: Any] = [
                "names": DataPersistence.candidates ?? []
            ]
                    
            let db = Firestore.firestore()
            db.collection("pick").document("candidates").setData(docData) { _ in
            }
        }
    }
}
