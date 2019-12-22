//
//  SecondViewController.swift
//  FilmFrame
//
//  Created by иван on 22/12/2019.
//  Copyright © 2019 иван. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var resultsLabel: UILabel!
    
    private var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsLabel.text = text
        
        // Do any additional setup after loading the view.
    }
    

    public func setText(_ text:String){
        self.text = text
    }

}
