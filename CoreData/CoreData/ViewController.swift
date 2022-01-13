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
    
    var dataAlbum: [Data] = []
    
    var imageAlbum: [UIImage] = []
    
    var name = "Photo_"
    
    var number = 01
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Documents"
        view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))

        setupTableView()
    }

    @objc func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
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
        let documentURL = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)


        let content = try! fileManager.contentsOfDirectory(at: documentURL,
                                                           includingPropertiesForKeys: nil,
                                                           options: [])

        return content.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        let documentURL = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)


        let content = try! fileManager.contentsOfDirectory(at: documentURL,
                                                           includingPropertiesForKeys: nil,
                                                           options: [])
        cell.textLabel?.text = String(describing: content[indexPath.row].lastPathComponent)
        cell.imageView?.image = UIImage(systemName: "photo")
        return cell
        
    }
}





extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            if let imageData = image.pngData() {
              
            
            let documentURL = try! fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            
                let pathToCreateDocument = documentURL.appendingPathComponent(name + String(describing: number))
            
                let fileExists = FileManager.default.fileExists(atPath: pathToCreateDocument.path)
            
            if fileExists == true {
                number+=1
                
                let pathToCreateDocumentIndex = documentURL.appendingPathComponent(name + String(describing: number))
                
                fileManager.createFile(atPath: pathToCreateDocumentIndex.path,
                                            contents: imageData,
                                            attributes: nil)
            } else {
                fileManager.createFile(atPath: pathToCreateDocument.path,
                                            contents: imageData,
                                            attributes: nil)
            }
                print(documentURL)

            }
        }
        picker.dismiss(animated: true, completion: nil)
        tableView.reloadData()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
