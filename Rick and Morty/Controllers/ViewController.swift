//
//  ViewController.swift
//  Rick and Morty
//
//  Created by Shahid Aaqeel on 2/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    var characterData: [Character] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        getDataFromAPI()
        
    }
    
    func getDataFromAPI() {
        let urlString = "https://rickandmortyapi.com/api/character"
        let url = URL(string: urlString)
        
        let header = [
            "cache-control": "max-age=259200, public",
            "content-length": "1454",
            "content-type": "application/json; charset=utf-8",
        ]
        
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 40)
        request.allHTTPHeaderFields = header
        request.httpMethod = "GET"
        
        //URL sesssion
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if data != nil {
                
                // Parse data
                
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Response.self, from: data!)
                    
                    if (!jsonData.results.isEmpty) {
                        self.characterData = jsonData.results
                        print(self.characterData.count)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                } catch {
                    print("Error in JSON parsing or request")
                }
            } else {
                print("Error \(error!)")
            }
        }
        dataTask.resume()
    }
    
}



extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell

        cell.setup(data: characterData[indexPath.row])
        return cell
    }

}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pickColorVC = storyboard.instantiateViewController(withIdentifier: "Info") as! InfoViewController
        pickColorVC.data = characterData[indexPath.row]
        self.present(pickColorVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader){
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Check")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


