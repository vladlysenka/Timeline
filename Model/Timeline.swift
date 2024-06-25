// Created by Vlad Lysenka 25.06.2024 

import SwiftUI

struct Timeline: Identifiable {
    var id: Int
    var company: String
    var position: String
    var summary: String
    var start: String
    var finish: String?
    
    static var data: [Timeline] = [
        Timeline(id: 4, company: "Lune", position: "iOS разработчик",
                 summary: "Разработал и опубликовал приложение в App Store. Исправляю ошибки и добавляю новый функционал", start: "2024", finish: nil),
        Timeline(id: 3, company: "Swift", position: "Обучение",
                 summary: "Самостоятельно изучал язык и нативные подходы разработки \n\nSwiftUI, SwiftData, Combine", start: "2023", finish: "2024"),
        Timeline(id: 2, company: "Сталь Строй Технологии", position: "Разметчик",
                 summary: "Разметка деталей, сборка и отправка фасовочных элементов. Освоил с нуля дыропробивной и сверлильный ЧПУ станки. Был страшим смены", start: "2020", finish: "2023"),
        Timeline(id: 1, company: "Double Tree by Hilton", position: "Бутблекер",
                 summary: "Осуществлял кресельную экспресс чистку обуви. Никогда не думал что обувь может так блестеть", start: "2019", finish: "2020"),
        Timeline(id: 0, company: "Ремесленник", position: "Изготовление изделий из кожи",
                 summary: "", start: "2017", finish: "2019")
    ]
}
