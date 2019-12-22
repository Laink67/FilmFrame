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
    @IBOutlet weak var itemResults: UIBarButtonItem!
    
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
    
    private var answers = 0
    private var correctAnswers = 0
    private var years = ""
    
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
            correctAnswers+=1
        }
        else{   
            sender.backgroundColor = UIColor.red
            sender.shake()
        }
        
        answers+=1
        delayUpdate()
    }
    
    public func setYears(_ years:String){
        self.years = years
    }
    
    // Updating correctAnswer, image and answers
    private func update(){
        correctAnswer = films[Int.random(in: 0...films.count - 1)]
        imageView.image = UIImage(named: correctAnswer)
        let rnd = Int.random(in: 0...5)
        var answers = [String]()
        let correctFilm = getFilmName(correctAnswer)
        var someNewAnswer = ""
        
        buttons[rnd]?.setTitle(correctFilm, for: .normal)
        
        while answers.count != 6 {
            someNewAnswer = getFilmName(films[Int.random(in: 0...films.count - 1)])
            if !answers.contains(someNewAnswer) && someNewAnswer != correctFilm{
                answers.append(someNewAnswer)
            }
        }
        
        for i in 0...5 where i != rnd{
            buttons[i]!.setTitle(answers[i],for: .normal)
        }
        
        buttonTransition()
        transitionAnimation(animationOptions: .transitionCrossDissolve, isReset: true)
        enableButtons()
    }
    
    // Get films from directory
    private func getAllFilms(){
        films.removeAll()
        let fileManager = FileManager.default
        
        if years == "All years"{
            films = try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1940_1970s") + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1970s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1980s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/1990s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/2000s")) + (try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/2010s"))
        }
        else{
            films = try! fileManager.contentsOfDirectory(atPath: "/Users/ivan/Desktop/FilmFrame/FilmFrame/images/\(years)")
        }
        
    }
    
    private func getFilmName(_ name:String) -> String{
        return name.components(separatedBy: "Ru")[1].replacingOccurrences(of: "_", with: " ")
    }

    // Animation of buttons for change answers
    private func buttonTransition(){
        for button in buttons{
            button!.transitionAnimation(animationOptions: .transitionFlipFromLeft, isReset: isAnimated)
        }
        
        isAnimated.toggle()
    }
    
    //Updating with some time to see animation
    private func delayUpdate(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        self.update()
        }
    }
    
    //Animation for images
    private func transitionAnimation(animationOptions: UIView.AnimationOptions, isReset: Bool) {
           UIView.transition(with: imageView, duration: 1.0, options: animationOptions, animations: {}, completion: nil)
       }
    
    private func disableButtons(){
        for button in buttons{
            button?.isEnabled = false
        }
    }
    
    private func enableButtons(){
        for button in buttons{
            button?.isEnabled = true
            button?.backgroundColor = mainColor
        }
    }
    
    public func getResults() -> String{
        return """
            Your results:
            Answers = \(answers)
            Correct = \(correctAnswers)
            """
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! SecondViewController
        secondViewController.setText(getResults())
    }
    
}

