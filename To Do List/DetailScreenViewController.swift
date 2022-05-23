//
//  DetailScreenViewController.swift
//  To Do List
//
//  Created by Burak Yılmaz on 23.05.2022.
//

import UIKit

class DetailScreenViewController: UIViewController {

   
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var note: UILabel!
    
    var noteTitleToShow:String?
    var noteToShow:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitle.text = noteTitleToShow
        note.text = noteToShow
    }
    



}
