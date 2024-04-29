//
//  NoteDetailViewController.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import UIKit

class NoteDetailViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var detailNote : Note?

    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteDescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if detailNote != nil {
            noteTitle.text = detailNote?.title
            noteDescription.text = detailNote?.content
        }
        else {
            detailNote = Note(context:  context)
            noteTitle.text = ""
            noteDescription.text = ""
        }
    }

    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        let isModal = self.presentingViewController is UINavigationController
                print("isModal: ",isModal)
                if isModal {
                    self.dismiss(animated: true)
                }
                else{
                    navigationController?.popViewController(animated: true)
                }

    }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! NoteDisplayerViewController
        detailNote?.title = noteTitle.text
        detailNote?.content = noteDescription.text
        
        destination.currentTask = detailNote
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        
        if let title = noteTitle.text {
            if let description = noteDescription.text{
                if (title.isEmpty || description.isEmpty){
                    self.show(warning: "Por favor complete los campos faltantes")
                }
                else {
                    perform = true
                }
            }
            
        }
        return perform
    }
}
