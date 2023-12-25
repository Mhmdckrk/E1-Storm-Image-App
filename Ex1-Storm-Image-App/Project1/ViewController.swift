//
//  ViewController.swift
//  Project1
//
//  Created by Mahmud CIKRIK on 24.09.2023.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        // başlık belirlendi
        navigationController?.navigationBar.prefersLargeTitles = true
        // başlık büyük yazıldı
        // sadece App'in ilk sayfasında büyük yaz.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Recommend", style: .plain, target: self, action: #selector(recommendApp))
        
        
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
        
        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        // bir bölümde oluşması gereken toplam satır sayısını hesaplatıp oluşturduk
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
        // her satırdaki hücreye getirilecek veriyi döndürmek için fonksiyon yazıyoruz galiba??
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Try loading the "Detail" view controller and typecasting it to be DetailViewController
        
        // 2.Step: We’ll implement the didSelectRowAt "method" so that it loads a "DetailViewController" from the storyboard.
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recommendApp() {
        
        
        let textToShare = "Benim harika bir uygulamam! İşte indirme bağlantısı: https://google.com/"
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        // İstediğiniz özel ayarlamaları yapabilirsiniz
        // activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]
        
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityViewController, animated: true, completion: nil)
        
        // Implement the recommendation functionality here
        // You can open a share sheet, send an email, or perform any other recommendation action.
    }
    
        
}

