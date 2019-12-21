//
//  ViewController.swift
//  FilmFrame
//
//  Created by иван on 20/12/2019.
//  Copyright © 2019 иван. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //Outlet for buttons
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    
    //Films
    private var films = [String]()
    private var correctAnswer = ""
    private var buttons = [UIButton?]()
    private var isAnimated = false
    private let mainColor = UIColor(named: "mainColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttons = [firstButton,secondButton,thirdButton,fourthButton,fifthButton,sixthButton]
        getAllFilms()
        
        update()
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        disableButtons()
        
        if(getFilmName(correctAnswer) == sender.titleLabel?.text){
            sender.pulsate()
        }
        else{   
            sender.backgroundColor = UIColor.red
            sender.shake()
        }
        
         delayUpdate()
    }
    
    // Updating correctAnswer, image and answers
    func update(){
        correctAnswer = films[Int.random(in: 0...films.count - 1)]
        imageView.image = UIImage(named: correctAnswer)
        let rnd = Int.random(in: 0...5)
        
        buttons[rnd]?.setTitle(getFilmName(correctAnswer), for: .normal)
        
        for i in 0...5 where i != rnd{
            buttons[i]!.setTitle(getFilmName(films[Int.random(in: 0...films.count - 1)]),for: .normal)
        }
        
        buttonTransition()
        transitionAnimation(animationOptions: .transitionCrossDissolve, isReset: true)
        enableButtons()
    }
    
    // Get films from directory
    func getAllFilms(){
        films.removeAll()
        let fileManager = FileManager.default
        
        films = try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1940_1970s") + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1970s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1980s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1990s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/2000s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/2010s"))
    }
    
    func getFilmName(_ name:String) -> String{
        return name.components(separatedBy: "Ru")[1].replacingOccurrences(of: "_", with: " ")
    }

    // Animation of buttons for change answers
    func buttonTransition(){
        for button in buttons{
            button!.transitionAnimation(animationOptions: .transitionFlipFromLeft, isReset: isAnimated)
        }
        
        isAnimated.toggle()
    }
    
    //Updating with some time to see animation
    func delayUpdate(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        self.update()
        }
    }
    
    //Animation for images
    func transitionAnimation(animationOptions: UIView.AnimationOptions, isReset: Bool) {
           UIView.transition(with: imageView, duration: 1.0, options: animationOptions, animations: {}, completion: nil)
       }
    
    func disableButtons(){
        for button in buttons{
            button?.isEnabled = false
        }
    }
    
    func enableButtons(){
        for button in buttons{
            button?.isEnabled = true
            button?.backgroundColor = mainColor
        }
    }
}

