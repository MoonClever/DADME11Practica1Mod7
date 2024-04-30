//
//  NoteManagerswift.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import Foundation

class NoteManager{
   
    private var notes : [Note] = []
    
    func createNote(note: Note){
        notes.append(note)
    }
    
    func updateNote(at index: Int, note: Note){
        notes[index] = note
    }
    
    func deleteNote(at index : Int) {
        notes.remove(at: index)
    }
    
    func getNotes() -> [Note]{
        return notes
    }
    
    func getNote(at index: Int) -> Note {
        return notes[index]
    }
    func countNotes() -> Int {
        return notes.count
    }
    
    func saveNotes(){
        //save json file with created notes
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("DD:", documentsDirectory)
        
        //v1
        let notesURL = documentsDirectory.appendingPathComponent("notes.json")
        print("notesURL:", notesURL)
        //v2
//        let notesURL2 = documentsDirectory.appending(path: "notes.json")
//        print("notesURL v2", notesURL2)
        
        //Save [Note] as json file
        do{
            let jsonData = try JSONEncoder().encode(notes)
            fileManager.createFile(atPath: notesURL.path, contents: jsonData)
        }
        catch let error {
            print(error)
        }
    }
    
    func loadNotes() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesURL = documentDirectory.appendingPathComponent("notes.json")
        
        //check if file exists
        if fileManager.fileExists(atPath: notesURL.path){
            do {
                let jsonData = fileManager.contents(atPath: notesURL.path)
                //Decode json file into array
                notes = try JSONDecoder().decode([Note].self, from: jsonData!)
            }
            catch let error {
                print("error: ", error)
            }
        }
        else{
            print("No se localizo el archivo")
        }
    }
    
}


