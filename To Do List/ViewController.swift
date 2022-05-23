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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        
        
        if let item = items?[indexPath.row]{
            cell.textLabel?.text = item.title
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        //Update Note
        
        note = items![indexPath.row]
        performSegue(withIdentifier: "addNote", sender:self)
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addNoteVC = segue.destination as? AddNoteViewController
        
        if note != nil{
            addNoteVC?.noteObject = note
            note = nil
        }else{
            addNoteVC?.noteObject = nil
        }
       
        
    }
    
    
}

