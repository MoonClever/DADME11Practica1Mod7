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
    
    var isEditOp : Bool = false


    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    @IBOutlet weak var sizeSlider: UISlider!
    
    @IBOutlet weak var colorPicker: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if detailNote != nil {
            isEditOp = true
            noteTitle.text = detailNote?.title
            noteContent.text = detailNote?.content
            sizeSlider.value = detailNote!.size
            colorPicker.selectedColor = UIColor(red: detailNote!.color[0], green: detailNote!.color[1], blue: detailNote!.color[2], alpha: detailNote!.color[3])
        }
        else {
            isEditOp = false
            noteTitle.text = ""
            noteContent.text = ""
            sizeSlider.value = 14.0
            colorPicker.selectedColor = UIColor(red: 0.5,green: 0.5,blue: 0.5,alpha: 1)
            
            detailNote = Note(title: "", content: "", size: 14.0, color: [0.5,0.5,0.5,1])
        }
    }

    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        let isModal = self.presentingViewController is UINavigationController
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
        detailNote?.title = noteTitle.text ?? ""
        detailNote?.content = noteContent.text ?? ""
        detailNote?.size = sizeSlider.value
        detailNote?.color = (colorPicker.selectedColor?.cgColor.components!)!
        destination.currentNote = detailNote
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var perform = false
        
        if let title = noteTitle.text {
            if let content = noteContent.text{
                if (title.isEmpty || content.isEmpty){
                    self.show(warning: "Ingrese todos los datos faltantes")
                }
                else {
                    perform = true
                }
            }
            
        }
        return perform
    }
}
