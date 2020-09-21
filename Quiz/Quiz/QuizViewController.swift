//
//  QuizViewController.swift
//  Quiz
//
//  Created by Yoshinori Shibahara on 2020/09/21.
//

import UIKit

class QuizViewController: UIViewController {
    
    var quizArray = [Any]()
    
    var correctAnswer: Int = 0
    
    @IBOutlet var quizTextView: UITextView!
    
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizArray.append(["問題文1", "選択肢1", "選択肢2", "選択肢3", 1])
        quizArray.append(["問題文2", "選択肢1", "選択肢2", "選択肢3", 2])
        quizArray.append(["問題文3", "選択肢1", "選択肢2", "選択肢3", 3])
        quizArray.append(["問題文4", "選択肢1", "選択肢2", "選択肢3", 1])
        quizArray.append(["問題文5", "選択肢1", "選択肢2", "選択肢3", 2])
        quizArray.append(["問題文6", "選択肢1", "選択肢2", "選択肢3", 3])
        
        quizArray.shuffle()
        
        choiceQuiz()

        // Do any additional setup after loading the view.
    }
    
    func choiceQuiz() {
        
        let tempArray = quizArray[0] as! [Any]
        
        quizTextView.text = tempArray[0] as? String
        
        choiceButton1.setTitle(tempArray[1] as? String, for: .normal)
        choiceButton2.setTitle(tempArray[2] as? String, for: .normal)
        choiceButton3.setTitle(tempArray[3] as? String, for: .normal)
    }
    
    func performSegueToResult() {
        
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        
        let tempArray = quizArray[0] as! [Any]
        
        if tempArray[4] as! Int == sender.tag {
            correctAnswer = correctAnswer + 1
        }
        
        quizArray.remove(at: 0)
        
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
