//
//  VenueTableViewCell.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 26/05/2022.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Function to bind VenueModel with the UI outlets
    func setData(venue: VenueModel) {
        self.nameLabel.text = venue.name
        
        var categoriesText: [String] = []
        
        for cat in venue.categories {
            categoriesText.append(cat.name)
        }
        
        
        let categoriesTextFormatted = categoriesText.formatted(.list(type: .and, width: .short))

        self.categoriesLabel.text = categoriesTextFormatted
    }
    
}
