//
//  DemoURL.swift
//  Cassini
//
//  Created by LiuScott on 15-4-14.
//  Copyright (c) 2015年 LiuScott. All rights reserved.
//

import Foundation

struct DemoURL {
    static let Stanford = NSURL(string: /*"http://www.sinaimg.cn/dy/slidenews/4_img/2015_12/704_1579346_230297.jpg")*/"http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png")
    struct NASA {
        static let Cassini = NSURL(string: "http://upload.wikimedia.org/wikipedia/commons/b/b2/Cassini_Saturn_Orbit_Insertion.jpg")//"http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg")
        static let Earth = NSURL(string: "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg")
        static let Saturn = NSURL(string: "http://www.nasa.gov/sites/default/files/saturn_collage.jpg")
    }
}