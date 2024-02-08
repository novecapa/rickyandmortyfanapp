//
//  Container+Builders.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 8/2/24.
//

extension Container {

    func mainBuilder() -> MainBuilder {
        return MainBuilder()
    }

    func detailBuilder() -> DetailBuilder {
        return DetailBuilder()
    }
}
