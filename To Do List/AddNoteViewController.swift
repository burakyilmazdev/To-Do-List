//
//  AddNoteViewController.swift
//  To Do List
//
//  Created by Burak Yılmaz on 18.05.2022.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var note: UITextField!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let viewController = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }    
    
    @IBAction func doneButton(_ sender: UIButton) {
   
        let newNote = Note(context: context)
        newNote.note = note.text
        newNote.title = noteTitle.text
        
        do{
            try context.save()
            showToast(message: "Saved", font: .systemFont(ofSize: 12.0))
        }catch{
            
        }
    }
    
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
    
}
