//
//  Cupcake.swift
//  App
//
//  Created by Botao Li on 7/16/19.
//

import Foundation
import Vapor
import FluentSQLite

struct Cupcake: Content, SQLiteModel, Migration {
	var id: Int?
	var name: String
	var description: String
	var price: Int
}
