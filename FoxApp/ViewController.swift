//
//  ViewController.swift
//  FoxApp
//
//  Created by Tigran Gishyan on 09.04.22.
//

import UIKit

class ViewController: UIViewController {
//    var imageView: UIImageView!
    var titleLabel: UILabel!
    var showAnotherImageButton: UIButton!
    var foxService = FoxService()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "Juniper_fox")
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTitleLabel()
        initImageView()
        initButton()
        constructHierarchy()
        activateConstraints()
        
        showAnotherImageButton.addTarget(
            self, action: #selector(buttonPressed), for: [.touchUpInside]
        )
    }
    
    @objc func buttonPressed() {
        foxService.getFoxImages { fox in
            guard let fox = fox else { return }
            
            let url = URL(string: fox.image)!
            self.imageView.load(url: url)
//
//            self.titleLabel.text = "Hello Random Foxie"
        }
    }
}

// MARK: - Layout
extension ViewController {
    private func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Hello Juniper"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func initImageView() {
        
    }
    
    private func initButton() {
        showAnotherImageButton = UIButton(type: .system)
        showAnotherImageButton.setTitle("Show Another Animal", for: .normal)
        showAnotherImageButton.setTitleColor(.white, for: .normal)
        showAnotherImageButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        showAnotherImageButton.backgroundColor = .red
        showAnotherImageButton.layer.cornerRadius = 12
        showAnotherImageButton.contentEdgeInsets = UIEdgeInsets(
            top: 12, left: 12, bottom: 12, right: 12
        )
        showAnotherImageButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constructHierarchy() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(showAnotherImageButton)
    }
    
    private func activateConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            imageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            showAnotherImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            showAnotherImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
    
    func load(url: URL) {
        DispatchQueue.main.async {
            self.image = UIImage(data: try! Data(contentsOf: url))!
        }
    }
}
