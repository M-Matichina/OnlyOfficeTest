//
//  CommonViewController.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/13/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    private var networkingService = NetworkingService.shared
    var folders: [Folder] = []
    var files: [File] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserDocsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        getCommonDocs()
    }
    
    
    // MARK: - Networking
    
    func getCommonDocs() {
        networkingService.request(t: UserDocsResponse(), api: .commonFiles, method: .get) { [weak self] (resp, error) in
            guard let self = self, let commonFiles = resp?.response else { return }
            
            self.folders = commonFiles.folders
            self.files = commonFiles.files
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView

extension CommonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? folders.count : files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserDocsTableViewCell
        cell.nameLabel.text = indexPath.section == 0 ? folders[indexPath.row].title : files[indexPath.row].title
        cell.subtitleLabel.text = indexPath.section == 0 ? folders[indexPath.row].created : files[indexPath.row].created
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let errorView = UIAlertController(title: "Внимание!", message: "В данной версии приложения не предусмотрено открытие папок", preferredStyle: .alert)
            errorView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorView, animated: true, completion: nil)
        } else if indexPath.section == 1 {
            let storyBoard = UIStoryboard(name: "File", bundle:nil)
            let fileViewController = storyBoard.instantiateViewController(withIdentifier: "FileDetailViewController") as! FileDetailViewController
            fileViewController.fileURL = files[indexPath.row].viewUrl
            self.navigationController?.pushViewController(fileViewController, animated: true)
        }
    }
}
