//
//  transform.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2023/11/14.
//

import Foundation

import Networks
import Domain

extension CurrentWeatherEntity {
    public func toDomain(of tag: Int) -> CurrentWeatherModel {
        return CurrentWeatherModel(
            tag: tag,
            place: name,
            weather: weather[0].main,
            temparature: main.temp,
            maxTemparature: main.tempMax,
            minTemparature: main.tempMin
        )
    }
}

//public func toDomain() -> UserMainInfoModel? {
//        guard let user = user, !user.name.isEmpty else { return nil }
//        return UserMainInfoModel.init(status: user.status, name: user.name, profileImage: user.profileImage, historyList: user.historyList, attendanceScore: operation?.attendanceScore, announcement: operation?.announcement, isAllConfirm: isAllConfirm)
//    }
