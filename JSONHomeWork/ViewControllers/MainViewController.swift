//
//  ViewController.swift
//  JSONHomeWork
//
//  Created by 1234 on 21.03.2023.
//

import UIKit


final class MainViewController: UIViewController {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    private var imageURL = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
//    К сожалению не получилось обратиться к JSON из createPeople в функции getImage. Поэтому изображения подгружаются не совсем корректно//
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        createPerson()
        getImage()
    }
    
}

//MARK: - Networking
extension MainViewController {
    private func createPerson() {
        networkManager.create(Human.self, from: Link.personUrl.url) { [weak self] result in
            switch result {
            case .success(let human):
                for person in human.results {
                    self?.nameLabel.text = "\(person.name.first) \(person.name.last)"
                    self?.genderLabel.text = "\(person.gender)"
                    self?.infoLabel.text = "Hello, I'm \(person.name.first) \(person.name.last) \n I live in \(person.location.country) country \(person.location.state) state and city \(person.location.city). \n You can write me on email: \n \(person.email)!"
                    self?.imageURL = person.picture.large
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    private func getImage() {
        networkManager.getImage(from: imageURL ?? Link.personUrl.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.photoImageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
