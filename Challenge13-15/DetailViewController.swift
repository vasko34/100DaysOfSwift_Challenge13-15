import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentImage = self.currentImage {
            imageView.image = UIImage(named: currentImage)
        }
    }
}
