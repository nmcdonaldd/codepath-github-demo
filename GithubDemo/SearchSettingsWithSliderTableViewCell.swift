//
//  SearchSettingsWithSliderTableViewCell.swift
//  GithubDemo
//
//  Created by Nick McDonald on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SearchSettingsWithSliderDelegate: class {
    func starsSliderChangedValue(_ value: Int)
}

class SearchSettingsWithSliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starsSlider: UISlider!
    @IBOutlet weak var starsLabel: UILabel!
    var sliderValue: Int = 0
    weak var delegate: SearchSettingsWithSliderDelegate?
    
    var numOfStars: Int = 0 {
        didSet {
            self.starsSlider.setValue(Float(numOfStars), animated: true)
            self.starsLabel.text = "\(numOfStars)"
        }
    }
    
    @IBAction func sliderChangedValue(_ sender: UISlider) {
        self.starsLabel.text = "\(Int(sender.value))"
        self.sliderValue = Int(sender.value)
        self.delegate?.starsSliderChangedValue(Int(sender.value))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.starsLabel.text = "0"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
