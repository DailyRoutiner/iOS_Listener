//
//  ViewController.swift
//  Listener
//  Seongjun Choi
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    let provider = BookProvider()
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        provider.addSamplesIfNeeded()
        books = provider.getAllBooks()
        setUpTableView()
    }

    func setUpTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BookCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BookCollectionCell")
        
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToBookDetail"{
            let bookDetailVC = segue.destination as! BookDetailViewController
            if let index = collectionView.indexPathsForSelectedItems {
                bookDetailVC.configData(with: books[index[0].row])
            }
        }
    }
}

// MARK: - UICollectionView Cell
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath) as! BookCollectionCell
        cell.configure(with: books[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToBookDetail", sender: self)
      
    }
    
}
