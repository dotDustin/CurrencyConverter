//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Dustin Mahone on 7/9/20.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    // MARK: - Constants & Variables
    let apiKey = "YOUR_API_KEY"
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Actions
    
    @IBAction func getRatesButtonPressed(_ sender: Any) {
        
        if let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)") {
        
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                
                } else {
                    if data != nil {
                        
                        do {
                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                            
                            DispatchQueue.main.async {
                                if let rates = jsonResponse["rates"] as? [String : Double] {
                                    
                                    self.cadLabel.text = "\(rates["CAD"] ?? 0) CAD"
                                    self.chfLabel.text = "\(rates["CHF"] ?? 0) CHF"
                                    self.gbpLabel.text = "\(rates["GBP"] ?? 0) GBP"
                                    self.jpyLabel.text = "\(rates["JPY"] ?? 0) JPY"
                                    self.usdLabel.text = "\(rates["USD"] ?? 0) USD"
                                    self.tryLabel.text = "\(rates["TRY"] ?? 0) TRY"
                                    
                                }
                                
                            }
                            
                        } catch {
                            DispatchQueue.main.async {
                                print("jsonserialization error")
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
            task.resume()
            
    }
        
    }
    
}

