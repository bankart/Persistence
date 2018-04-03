//
//  ViewController.swift
//  Persistence
//
//  Created by taehoon lee on 2018. 4. 3..
//  Copyright © 2018년 taehoon lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let cellId = "CellId"
    private var persons = [Person]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            persons = try PersistenceManager.context().fetch(Person.fetchRequest())
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTestButton(_ sender: UIBarButtonItem) {
        CourseLoader.getCourseData()
        CourseLoader.getWebsiteDescription()
    }
    
    @IBAction func addPerson(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: "do you wanna add more person?", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "name"
        }
        alert.addTextField { (tf) in
            tf.placeholder = "age"
            tf.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Post", style: .default, handler: { (_) in
            let person = Person(context: PersistenceManager.context())
            person.name = alert.textFields!.first!.text!
            person.age = Int16(alert.textFields!.last!.text!)!
            self.persons.append(person)
            PersistenceManager.saveContext()
            
            self.tableView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        guard persons.count > indexPath.row else {
            return cell!
        }
        
        cell!.textLabel?.text = persons[indexPath.row].name
        cell!.detailTextLabel?.text = String(persons[indexPath.row].age)
        
        return cell!
    }
    
    
}
