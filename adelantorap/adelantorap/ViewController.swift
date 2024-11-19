//
//  ViewController.swift
//  adelantorap
//
//  Created by Alumno on 19/11/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let pisto: [Pisto] = [
        Pisto(nombre: "Mr. Blue", imageName: "azul", ingrediente: ["Alcohol adulterado", "Sprite", "Hielo", "Volt mora azul"], review: "Si me meto thinner es porque hay recuerdos de ti que no puedo borrar."),
        Pisto(nombre: "BacarDios", imageName: "bacacho", ingrediente: ["Cocacola", "limon", "Hielo", "Tehuacan"], review: "Perfecta sin tanto ruido para que no escuche el sordo y le diga al mudo."),
        Pisto(nombre: "Don Tony Ayan", imageName: "ciego", ingrediente: ["Caña", "Hielo", "Alcohol del 96"], review: "Fresco y dulce, como chivo al pasto.")
    ]
    
    var expandedIndex: IndexPath? = nil
    
   // Profe aqui nos marcaba error y como no estaba para preguntarle, tuvimos que usar lazy para que compilara
     lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 9
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
        collectionView.register(PistoCell.self, forCellWithReuseIdentifier: "PistoCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        coleccion()
    }
    
     func coleccion() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pisto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PistoCell", for: indexPath) as? PistoCell else {
            return UICollectionViewCell()
        }
        
        let pisto = pisto[indexPath.item]
        cell.configure(with: pisto, isExpanded: indexPath == expandedIndex, at: indexPath)
        cell.cierrate = { [weak self] in
            // Colapsar la celda al presionar
            if self?.expandedIndex == indexPath {
                self?.expandedIndex = nil
            } else {
                self?.expandedIndex = indexPath
            }
            collectionView.performBatchUpdates({
                collectionView.reloadItems(at: [indexPath])
            }, completion: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if expandedIndex == indexPath {
            expandedIndex = nil
        } else {
            expandedIndex = indexPath
        }
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == expandedIndex {
            return CGSize(width: view.frame.width - 32, height: 300)
        } else {
            return CGSize(width: 150, height: 250)  
        }
    }
}
