//
//  RecipeViewCell.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-15.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    
    static let identifier:String = "RecipeViewCell"
    
    @UsesAutoLayout
    private(set) var cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        return cardView
    }()
    
    @UsesAutoLayout
    private(set) var foodImageView: UIImageView = {
        let foodImageView = UIImageView()
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        foodImageView.layer.cornerRadius = 10
        foodImageView.layer.masksToBounds = true
        foodImageView.backgroundColor = .clear
        return foodImageView
        
    }()
    
    @UsesAutoLayout
    private(set) var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
 
    @UsesAutoLayout
    private(set) var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
        timeLabel.numberOfLines = 1
        return timeLabel
    }()
    
    @UsesAutoLayout
    private(set) var levelLabel: UILabel = {
        let levelLabel = UILabel()
        levelLabel.font = UIFont.boldSystemFont(ofSize: 12)
        levelLabel.textColor = .orange
        levelLabel.textAlignment = .right
        levelLabel.numberOfLines = 1
        levelLabel.adjustsFontSizeToFitWidth = true
        levelLabel.minimumScaleFactor = 0.5
        return levelLabel
    }()
    
    @UsesAutoLayout
    private(set) var pointLabel: UILabel = {
        let pointLabel = UILabel()
        pointLabel.font = UIFont.systemFont(ofSize: 12)
        pointLabel.textColor = .gray
        pointLabel.numberOfLines = 1
        return pointLabel
        
    }()
    
    @UsesAutoLayout
    private(set) var retryButton: UIButton = {
        let retryButton = UIButton(type: .system)
        retryButton.setTitle("Click to reload image", for: .normal)
        retryButton.layer.borderColor = UIColor.black.cgColor
        retryButton.isHidden = true
        retryButton.titleLabel?.font = .systemFont(ofSize: 12)
        retryButton.titleLabel?.numberOfLines = 2
        return retryButton
    }()
    
    @UsesAutoLayout
    private(set) var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let padding: CGFloat = 16
    let minorPadding: CGFloat = 8
    
    var foodImageUrl = ""
    var retryDownlaodImageAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
        retryButton.isHidden = true
    }
    
    @objc private func retryButtonTapped() {
        retryDownlaodImageAction?()
    }
    
    private func setupUI() {
        contentView.addSubview(cardView)
        [foodImageView, titleLabel, levelLabel, timeLabel, pointLabel, activityIndicator, retryButton].forEach {
            cardView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            levelLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: minorPadding),
            levelLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            levelLabel.widthAnchor.constraint(equalToConstant: 50),
            
            foodImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 0),
            foodImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 0),
            foodImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            foodImageView.widthAnchor.constraint(equalToConstant: 104),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor,constant: minorPadding),
            titleLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: levelLabel.leadingAnchor, constant: -padding),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
            timeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            
            pointLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 4),
            pointLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: padding),
            pointLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            pointLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding),
            
            activityIndicator.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            activityIndicator.topAnchor.constraint(equalTo: cardView.topAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 104),
            activityIndicator.heightAnchor.constraint(equalToConstant: 104),
            
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 30),
            retryButton.centerXAnchor.constraint(equalTo: foodImageView.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor)
        ])
    }
    
    func configCell(recipt: Recipe) {
        foodImageView.image = UIImage()
        titleLabel.text = recipt.name
        levelLabel.text = recipt.difficultyLevel.rawValue
        timeLabel.text = "Preparation Time: \(recipt.preparationTime) min"
        pointLabel.text = "Point: \(recipt.points)"
        foodImageUrl = recipt.smallImage?.url ?? ""
        activityIndicator.startAnimating()
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.retryButton.isHidden = true
            self.activityIndicator.stopAnimating()
            self.foodImageView.image = image
        }
    }
    
    func setRetryDownloadImage(retryAction: @escaping (()->Void)) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.retryButton.isHidden = false
            self.retryDownlaodImageAction = retryAction
            self.retryButton.addTarget(self, action: #selector(self.retryButtonTapped), for: .touchUpInside)
        }
        
    }
}
