//
//  ViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 11.01.2022.
//

import UIKit



class DocumentsViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    var cellID = "cellID"

    let fileManager = FileManager.default
    
    var parthToItems : [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Documents"
        view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
                
        setupTableView()
        print("Путь - \(FileManager.getDocumentDirectory())")
        addToFolder()
        
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
    
    
    func addToFolder() {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        if let url = documentsUrl {
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
                self.parthToItems = directoryContents
            } catch {
            }
        }
    }
}
    

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parthToItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellID)
        

        cell.textLabel?.text = String(describing: self.parthToItems[indexPath.row].lastPathComponent)
        cell.imageView?.image = UIImage(systemName: "photo")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("Deleting...")
            
            self.parthToItems.remove(at: indexPath.row)
            let url = parthToItems[indexPath.row]
            try? FileManager.default.removeItem(at: url)
            
            tableView.reloadData()
        default:
            print("ololo")
        }
        tableView.reloadData()
    }
}



extension DocumentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = FileManager.getDocumentDirectory().appendingPathComponent(imageName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: imagePath)
            print(imageName)
        }

        dismiss(animated: true)
        addToFolder()
        tableView.reloadData()
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
