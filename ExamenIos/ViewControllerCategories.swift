//
//  ViewControllerCategories.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit

class ViewControllerCategories: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    var listPost:[postClass] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
        listPost = createList()
     
    }
    
    
    func createList() -> Array<postClass> {
        var listPost: [postClass] = []
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 1", locationPost: "Ubicacion 1", messagePost: "Mensage de prueba", imagePost: "edificio", pricePost: "$340.00"))
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 2", locationPost: "Ubicacion 2", messagePost: "Mensage de prueba", imagePost: "", pricePost: "$350.00"))
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 3", locationPost: "Ubicacion 2", messagePost: "Mensage de prueba", imagePost: "", pricePost: "$360.00"))
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 4", locationPost: "Ubicacion 2", messagePost: "Mensage de prueba", imagePost: "", pricePost: "$370.00"))
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 5", locationPost: "Ubicacion 2", messagePost: "Mensage de prueba", imagePost: "", pricePost: "$380.00"))
        listPost.append(postClass(imageProfile: "person1", nameProfile: "Nombre 6", locationPost: "Ubicacion 2", messagePost: "Mensage de prueba", imagePost: "", pricePost: "$390.00"))
        return listPost
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCellCategories
        
        cell.namePost.text = listPost[indexPath.row].nameProfile
        cell.photoProfilePost.image = UIImage(named: listPost[indexPath.row].imageProfile)
        cell.photoProfilePost.layer.cornerRadius = cell.photoProfilePost.frame.size.width/2
        cell.photoProfilePost.clipsToBounds = true
        cell.locationPost.text = listPost[indexPath.row].locationPost
        cell.pricePost.text = listPost[indexPath.row].pricePost

        let screeSize = UIScreen.main.bounds
        if(listPost[indexPath.row].imagePost != ""){
            cell.imagePost.image = UIImage(named: listPost[indexPath.row].imagePost)
            cell.viewCell.frame = CGRect(x: 16, y: 0, width: (screeSize.width - 32) , height: 220)
        }else{
            cell.viewCell.frame = CGRect(x: 16, y: 0, width: (screeSize.width - 32) , height: 220)
        }
        
        return cell
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screeSize = UIScreen.main.bounds
        return CGSize(width: screeSize.width, height: 220)
    }*/
    


}
