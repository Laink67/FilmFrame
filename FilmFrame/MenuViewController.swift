//
//  MenuViewController.swift
//  FilmFrame
//
//  Created by иван on 22/12/2019.
//  Copyright © 2019 иван. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var years = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func clickButtonYears(_ sender: UIButton) {
        years = sender.titleLabel?.text ?? "All years"
        performSegue(withIdentifier: "mainView", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        viewController.setYears(years)
    }
   

}
