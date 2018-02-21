import UIKit
import PlaygroundSupport

class ViewController: UIViewController {
    
    private let subscribeButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("START 7 DAY FREE TRIAL", for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subscribeButton)
        
        subscribeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        styleUIComponents()
    }
    
    private func styleUIComponents() {
        view.backgroundColor = .white
        
        subscribeButton.layer.cornerRadius = 8
        subscribeButton.backgroundColor = UIColor.red
        subscribeButton.setTitleColor(.white, for: .normal)
    }
}

PlaygroundPage.current.liveView = ViewController()
