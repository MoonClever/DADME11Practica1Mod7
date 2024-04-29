//
//  NoteDisplayerViewController.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import UIKit

class NoteDisplayerViewController: UIViewController {

    
    @IBOutlet var emptyNoteView: UIView!
    
    @IBOutlet weak var noteDisplay: UITableView!
    
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    
    
    var currentTask: Note?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var taskManager : NoteManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        toDoList.delegate = self
//        toDoList.dataSource = self
        taskManager = NoteManager(context: context)
        taskManager?.fetch()
    }
    
    
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        if noteDisplay.isEditing{
            noteDisplay.setEditing(false, animated: true)
            sender.title = "Edit"
            addNoteButton.isEnabled = true
        }
        else{
            noteDisplay.setEditing(true, animated: true)
            sender.title = "Done"
            addNoteButton.isEnabled = false
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskSegue" {
            let destination = segue.destination as! NoteDetailViewController
            destination.detailNote = taskManager?.getAllNotes()[noteDisplay.indexPathForSelectedRow!.row]
            
        }
            
    }
    

}


extension NoteDisplayerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if taskManager?.countNotes() == 0 {
            emptyNoteView.isHidden = false
            noteDisplay.backgroundView = emptyNoteView
        }
        else{
            emptyNoteView.isHidden = true
        }
        
        return (taskManager?.countNotes())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCardViewCell
        cell.noteTitle.text = taskManager?.getAllNotes()[indexPath.row].title
        cell.noteContent.text = taskManager?.getAllNotes()[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTaskSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTask = taskManager?.getAllNotes()[indexPath.row]
            self.context.delete(currentTask!)
            
            do{
                try self.context.save()
            }
            catch let error {
                print("Error: ", error)
            }
        }
        taskManager?.fetch()
        noteDisplay.reloadData()
    }
    
    
    
    @IBAction func unWindToToDoList(segue : UIStoryboardSegue){
        print("Unwind Segue!!")
        let source = segue.source as! NoteDetailViewController
        currentTask = source.detailNote
        
        do{
            try context.save()
        }
        catch let error{
            print("Error: ", error)
        }
        //Show updated task list
        taskManager?.fetch()
        //reload table data
        noteDisplay.reloadData()
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
