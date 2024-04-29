//
//  NoteManagerswift.swift
//  Notes
//
//  Created by User on 29/04/24.
//

import Foundation
import CoreData

class NoteManager{
    private var noteList: [Note] = []
    private var context : NSManagedObjectContext
    
    init(context : NSManagedObjectContext){
        self.context = context
    }
    
    func fetch(){
        do{
            self.noteList = try self.context.fetch(Note.fetchRequest())
        }
        catch let error{
            print("error: ", error)
        }

    }
    
    func countNotes() -> Int {
        return noteList.count
    }
    
    
    func createNote(title: String, uuid : UUID, content : String) -> Note?{
        let newNote = Note(context: context)
        newNote.title = title
        newNote.id = UUID()
        newNote.content = content
        
        do{
            try context.save()
            return newNote
        }
        catch let error {
            print("Error: ", error)
            return nil
        }
    }
    
    func getAllNotes() -> [Note]{
        if let noteList = try? self.context.fetch(Note.fetchRequest()){
            return noteList
        }
        else{
            return []
        }
    }
    
    func getNoteByID(uuid: UUID) -> Note?{
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        var predicate : NSPredicate?
        
        predicate  = NSPredicate(format: "id = %@", uuid as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do{
            let note = try context.fetch(fetchRequest)
            return note.first
        }
        catch let error {
            print("error: ", error)
            return nil
        }
    }
    
    func updateNote(note: Note, title: String, uuid : UUID, content : String, date : Date) -> Note{
        note.title = title
        note.id = UUID()
        note.content = content
        
        do{
            try context.save()
        }
        catch let error{
            print("Error: ", error)
        }
        
        return note
        
    }
    
    func deleteNote(note : Note) -> Bool{
        
        self.context.delete(note)
        
        do{
            try context.save()
            return true
        }
        catch let error{
            print("Error: ", error)
            return false
        }
    }
    
    
}


