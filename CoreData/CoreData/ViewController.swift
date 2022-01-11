//
//  ViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 11.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    var cellID = "cellID"

    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Documents"
        view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))

        setupTableView()
        fileManagerSetup()
    }

    @objc func addPhoto() {
        print("OLOLO")
    }
    
    func fileManagerSetup() {
        let documentURL = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        
        print(documentURL)
        
        let content = try! fileManager.contentsOfDirectory(at: documentURL,
                                                           includingPropertiesForKeys: nil,
                                                           options: [])
        
        content.forEach {
            print("url is: \($0.absoluteURL)")
        }
    }
    
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
       // let post = arrayNames[indexPath.row]
       // cell.textLabel?.text = post
        return cell
    }
}
