//
//  FormType.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 18.06.2026.
//

import Foundation

enum FormType<T> {
    case create
    case edit(T?)
}
