//
//  NoteDisplayerViewController.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import UIKit

class NoteDisplayerViewController: UIViewController {

    @IBOutlet weak var emptyNoteView: UIImageView!
    
    @IBOutlet weak var noteDisplay: UITableView!
    
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    
    
    var currentNote: Note?
    var noteManager : NoteManager?
    
    var isEdit : Bool = false
    var editIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        toDoList.delegate = self
//        toDoList.dataSource = self
        noteManager = NoteManager()
        //noteManager?.saveNotes()
        noteManager?.loadNotes()
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
            destination.detailNote = noteManager?.getNote(at: noteDisplay.indexPathForSelectedRow!.row)
            
        }
            
    }
}


extension NoteDisplayerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noteManager?.countNotes() == 0 {
            emptyNoteView.isHidden = false
            noteDisplay.backgroundView = emptyNoteView
        }
        else{
            emptyNoteView.isHidden = true
        }
        
        return (noteManager?.countNotes())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCardViewCell
        let color = noteManager?.getNote(at: indexPath.row).color
        let size = noteManager?.getNote(at: indexPath.row).size
        
        cell.noteTitle.text = noteManager?.getNote(at: indexPath.row).title
        cell.noteContent.text = noteManager?.getNote(at: indexPath.row).content
        
        
        cell.noteTitle.textColor = UIColor(red: color?[0] ?? 0, green: color?[1] ?? 0, blue: color?[2] ?? 0, alpha: color?[3] ?? 0)
        cell.noteContent.textColor = UIColor(red: color?[0] ?? 0, green: color?[1] ?? 0, blue: color?[2] ?? 0, alpha: color?[3] ?? 0)
        
        cell.noteTitle.font?.withSize(CGFloat(size ?? 14))
        cell.noteContent.font?.withSize(CGFloat(size ?? 14))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        editIndex = indexPath.row
        performSegue(withIdentifier: "showTaskSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            noteManager?.deleteNote(at: indexPath.row)
            noteManager?.saveNotes()
            
        }
        noteManager?.loadNotes()
        noteDisplay.reloadData()
    }
    
    
    
    @IBAction func unWindToToDoList(segue : UIStoryboardSegue){
        let source = segue.source as! NoteDetailViewController
        currentNote = source.detailNote
        isEdit = source.isEditOp
        if (isEdit){
            noteManager?.updateNote(at: editIndex, note: currentNote!)
            noteManager?.saveNotes()
        }
        else{
            noteManager?.createNote(note: currentNote!)
            noteManager?.saveNotes()
        }
        
        //Show updated task list
        noteManager?.loadNotes()
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
