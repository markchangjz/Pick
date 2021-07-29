import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = DataPersistence.candidates?.randomElement()
    }

    @IBAction func share(_ sender: UIButton) {
        let shareText = "Go for \"\(resultLabel.text!)\""
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
