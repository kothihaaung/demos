//
//  memo.swift
//  TableViewDemo
//
//  Created by Thiha Aung on 2019/01/25.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import Foundation

public enum MemoCategory {
    case Work, Important, Personal
}

public class Memo {
    
    var title :String?
    var category: MemoCategory?
    var overview: String?
    var detail: String?
}
