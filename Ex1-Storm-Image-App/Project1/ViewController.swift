//
//  ViewController.swift
//  Project1
//
//  Created by Mahmud CIKRIK on 24.09.2023.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var viewCounts = [Int]()
    //var cellTapCounts = [String: Int]()
    var titleChanger = "Storm Viewer"



    override func viewDidLoad() {
        super.viewDidLoad()
        loadTapCounts()
        loadTitle()
        // Do any additional setup after loading the view.
        
        title = titleChanger
        // başlık belirlendi
        navigationController?.navigationBar.prefersLargeTitles = true
        // başlık büyük yazıldı
        // sadece App'in ilk sayfasında büyük yaz.
        
        performSelector(inBackground: #selector(loadImageList), with: nil)
       

        
    }

    @objc func loadImageList () {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load
                pictures.append(item)
            }
        }
        
        pictures = pictures.sorted { $0 < $1 }
        if viewCounts.count == 0 {
            viewCounts = [Int](repeating: 0, count: pictures.count)
        }

//        bu alttaki kod olmasa da bir fark görünmüyor bunun çalıştığını nasıl analyabilirim
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
      
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return pictures.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "\(viewCounts[indexPath.row]) times viewed"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Try loading the "Detail" view controller and typecasting it to be DetailViewController
        
        // 2.Step: We’ll implement the didSelectRowAt "method" so that it loads a "DetailViewController" from the storyboard.
        titleChanger = "Osman"
        title = titleChanger
        saveTitle()
        viewCounts[indexPath.row] += 1
//        if cellTapCounts[pictures[indexPath.row]] == nil {
//            cellTapCounts[pictures[indexPath.row]] = viewCounts[indexPath.row]
//            saveTapCounts()
//            }
//        cellTapCounts[pictures[indexPath.row]] = viewCounts[indexPath.row]
        saveTapCounts()
        tableView.reloadRows(at: [indexPath], with: .none)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveTapCounts() {
        UserDefaults.standard.set(viewCounts, forKey: "ViewCounts")
    }
    
    func loadTapCounts() {
        if let savedViewCounts = UserDefaults.standard.array(forKey: "ViewCounts") as? [Int] {
            viewCounts = savedViewCounts
        }
    }
    
    func saveTitle() {
        
        UserDefaults.standard.set(titleChanger, forKey: "Title")
        
    }
    
    func loadTitle() {
        
        if let savedTitle = UserDefaults.standard.string(forKey: "Title") {
            titleChanger = savedTitle
        }
    }
    
}

