//
//  UserAnnotationView.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/11/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import MapKit

class UserAnnotationView: MKAnnotationView, Identifiable {

    let annoWidth: CGFloat = 11.5

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect(x: 0.0, y: 0.0, width: annoWidth, height: annoWidth)

        backgroundColor = UIColor.red
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = annoWidth/2.0

        canShowCallout = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
