import UIKit

class ResultViewController: UIViewController {

    var resultText: String?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = resultText
    }

    @IBAction func share(_ sender: UIButton) {
        let googleMapsLink = "comgooglemaps://?q=\(resultLabel.text!)"
        let shareText = "Go for \"\(resultLabel.text!)\n\nGoogle Maps: \(googleMapsLink)"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
