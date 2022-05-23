//
//  ViewController.swift
//  To Do List
//
//  Created by Burak Yılmaz on 18.05.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Note]?
    var note:Note?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let nib = UINib(nibName: "CustomNoteCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomNoteCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchNotes()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        fetchNotes()
    }
    
    
    
    
    func fetchNotes(){
        do{
            self.items = try context.fetch(Note.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNoteCell") as! CustomNoteCell
        
        
        if let item = items?[indexPath.row]{
            cell.title.text = item.title
            cell.noteText.text = item.note
        }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let noteToRemove = self.items![indexPath.row]
            
            self.context.delete(noteToRemove)
            
            do{
                try self.context.save()
            }catch{
                
            }
            
            self.fetchNotes()
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Update Note
        
        let action = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
            
            self.note = self.items![indexPath.row]
            self.performSegue(withIdentifier: "addNote", sender:self)
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        note = items![indexPath.row]
        performSegue(withIdentifier: "mainToDetail", sender:self)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
            
        case "addNote":
            print("add note")

            let addNoteVC = segue.destination as? AddNoteViewController
            
            if self.note != nil{
                addNoteVC?.noteObject = self.note
                self.note = nil
            }else{
                addNoteVC?.noteObject = nil
            }
            
            
        case "mainToDetail":
            let detailScreenVC = segue.destination as? DetailScreenViewController
                        
            detailScreenVC?.noteToShow = note!.note!
            detailScreenVC?.noteTitleToShow = note!.title!
            note = nil

        default:
            print("default")
            
            
        }
        
    }
    
    
}

