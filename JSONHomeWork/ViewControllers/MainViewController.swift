//
//  ViewController.swift
//  JSONHomeWork
//
//  Created by 1234 on 21.03.2023.
//

import UIKit


final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPerson()
    }
    
    let personURL = "https://randomuser.me/api/"
    
}
    
    extension MainViewController {
        
        private func getPerson() {
            guard let url = URL(string: personURL) else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                let decoder = JSONDecoder()
                
                do {
                    let personInfo = try decoder.decode(Result.self, from: data)
                    print(personInfo)
                } catch let error {
                    print(error)
                }
            }.resume()
            
        }
    }
