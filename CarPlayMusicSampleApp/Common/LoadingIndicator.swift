//
//
//
//
//import UIKit
//import ImageIO
//
//extension UIImage {
//    public class func gif(data: Data) -> UIImage? {
//        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
//            print("Image source is nil")
//            return nil
//        }
//
//        return UIImage.animatedImageWithSource(source)
//    }
//
//    private class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
//        let count = CGImageSourceGetCount(source)
//        var images = [UIImage]()
//        var duration: TimeInterval = 0
//
//        for i in 0..<count {
//            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
//            let frameDuration = UIImage.frameDurationAtIndex(index: i, source: source)
//            duration += frameDuration
//            images.append(UIImage(cgImage: cgImage))
//        }
//
//        let animation = UIImage.animatedImage(with: images, duration: duration)
//        return animation
//    }
//
//    private class func frameDurationAtIndex(index: Int, source: CGImageSource) -> TimeInterval {
//        let defaultFrameDuration = 0.1
//
//        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any] else {
//            return defaultFrameDuration
//        }
//
//        guard let gifProperties = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else {
//            return defaultFrameDuration
//        }
//
//        guard let frameDuration = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? TimeInterval else {
//            return defaultFrameDuration
//        }
//
//        return frameDuration
//    }
//}
//
//
//class LoadingIndicator {
//    static let shared = LoadingIndicator() // Singleton instance
//
//    private var loadingView: UIView?
//    private var imageView: UIImageView?
//
//    private init() {
//        setupLoadingView()
//    }
//
//    private func setupLoadingView() {
//        // Create the loading view and set its properties
//        loadingView = UIView(frame: UIScreen.main.bounds)
//        loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.7)
//
//        // Create the image view for the animation
//        imageView = UIImageView()
//        imageView?.contentMode = .scaleAspectFit
//
//        // Add the image view to the loading view
//        if let loadingView = loadingView, let imageView = imageView {
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            loadingView.addSubview(imageView)
//
//            // Center the image view within the loading view
//            NSLayoutConstraint.activate([
//                imageView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
//                imageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
//                imageView.widthAnchor.constraint(equalToConstant: 250),
//                imageView.heightAnchor.constraint(equalToConstant: 250)
//            ])
//        }
//    }
//
//    func showLoadingIndicator(on view: UIView) {
//        guard let loadingView = loadingView, let imageView = imageView else { return }
//
//        // Load the GIF data
//        guard let gifPath = Bundle.main.path(forResource: "Vector 5@3x (1)", ofType: "gif"),
//              let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)),
//              let gifImage = UIImage.gif(data: gifData) else {
//            print("Failed to load GIF")
//            return
//        }
//
//        // Set the GIF image and start animating
//        imageView.image = gifImage
//
//        // Add the loading view to the specified view
//        view.addSubview(loadingView)
//    }
//
//    func hideLoadingIndicator() {
//        imageView?.stopAnimating()
//        loadingView?.removeFromSuperview()
//    }
//}
import UIKit

class CustomLoadingViewController: UIViewController {

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure imageView with your "Loding" image
        imageView.image = UIImage(named: "Loding")
        imageView.contentMode = .scaleAspectFit // Adjust content mode as needed
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Setup constraints to center imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100), // Adjust size as needed
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // Start animation if needed
        startAnimation()
    }

    private func startAnimation() {
        // Implement animation logic here if needed
        // Example: Rotate the image
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.imageView.transform = self.imageView.transform.rotated(by: .pi)
        }, completion: nil)
    }

    // Optional: Stop animation if needed
    private func stopAnimation() {
        imageView.layer.removeAllAnimations()
    }
}
