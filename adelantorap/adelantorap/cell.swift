//
//  cell.swift
//  adelantorap
//
//  Created by Alumno on 19/11/24.
//

import UIKit

class PistoCell: UICollectionViewCell {
    
     let imageView = UIImageView()
     let nombreLabel = UILabel()
     let ingredienteLabel = UILabel()
     let reviewLabel = UILabel()
    
    var cierrate: (() -> Void)?
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        BONITA()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no esta implementada padrino")
    }
    
    func configure(with pisto: Pisto, isExpanded: Bool, at indexPath: IndexPath) {
        self.indexPath = indexPath
        imageView.image = UIImage(named: pisto.imageName)
        nombreLabel.text = pisto.nombre
        ingredienteLabel.text = "Ingredientes: \(pisto.ingrediente.joined(separator: ", "))"
        reviewLabel.text = pisto.review
        ingredienteLabel.isHidden = !isExpanded
        reviewLabel.isHidden = !isExpanded
    }
    
     func BONITA() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .black
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        nombreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nombreLabel.textAlignment = .center
        nombreLabel.textColor = .white
        ingredienteLabel.font = UIFont.systemFont(ofSize: 15)
        ingredienteLabel.textColor = .white
        ingredienteLabel.numberOfLines = 0
        reviewLabel.font = UIFont.systemFont(ofSize: 15)
        reviewLabel.textColor = .white
        reviewLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nombreLabel, ingredienteLabel, reviewLabel])
        stackView.axis = .vertical
        stackView.spacing = 2  
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
     func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.contentView.addGestureRecognizer(gesture)
    }
    
    @objc func tapGesture() {
        cierrate?()
    }
}
