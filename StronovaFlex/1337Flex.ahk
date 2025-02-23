﻿/*
Новые
5 запись
5.5 применение

Настройки чувствительности в игре 5.5-1-1-1-1-1-1
Основы - Отображение плавающего урона - Наложение
Сглаживание - TAA

V - Аимбот
C - Триггер
F3 - Переключить режим аимбота, AR mode(по умолчанию), DMR mode(марксманские винтовки)
F4 - Переключить режим триггера, 0 - Off, 1 - PixlGetColor, 2 - PixlSearch
F7 - Фастпик
Ctrl + Down - Уменьшить область захвата пикселей триггера
Ctrl + Up - Увеличить область захвата пикселей триггера
Home - Перезагрузить
End - Завершить работу

Numpad0 - Off
Numpad1 - Мишель (Инспектор)
Numpad2 - Ивет (ГОООООЛ!!!)
Numpad3 - Нобунага (Судья), Маддалена (Хрома)
Numpad4 - Флавия (Соло)
Numpad5 - Мин (Мятежное пламя) АК47
Numpad6 - Мередит (Сокол) Ауг
Numpad7 - Лоуин (Тень)
Numpad8 - Селестия (БиПолярная звезда)
Numpad9 - Одри (Чемпион) M249
NumpadAdd - Фуксия (Зубец)
NumpadSub - Фрагранс (Цветение)
NumpadMult - Эйка (Пожар)

*/

#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance force
SetBatchLines, -1

CommandLine := DllCall("GetCommandLine", "Str")
If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
	Try {
		If (A_IsCompiled) {
			Run *RunAs "%A_ScriptFullPath%" /restart
		} Else {
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
		}
	}
	ExitApp
}


Menu,Tray, Icon, %A_ScriptDir%\data\icon.ico
Menu,Tray, NoStandard
Menu,Tray, DeleteAll
Menu,Tray, add, Menu, MetkaMenu3
Menu,Tray, Disable, Menu
Menu,Tray, Icon, Menu, shell32.dll,264, 16
Menu,Tray, add
Menu,Tray, add, Reload, MetkaMenu2
Menu,Tray, Icon, Reload, shell32.dll, 239, 16
Menu,Tray, add, Exit, MetkaMenu1
Menu,Tray, Icon, Exit, shell32.dll,28, 16
Gui, -Caption +AlwaysOnTop
Gui, Add, Button, gStart w100 h30, Start
Gui, Add, Button, gHashChanger w100 h30, Hash Changer
Gui, Add, Button, gNameChanger w100 h30, Name Changer
Gui, Add, Button, gUpCfg w100 h30, Import Config
Gui, Add, Button, gOpenConfig w100 h30, Open Config
Gui, Add, Button, gExit w100 h30, Exit
randomName := GenerateRandomName(15) ; 10 - длина имени
yPosGui := A_ScreenHeight // 2 - round(A_ScreenHeight * (300 / 1440))
Gui, Show, y%yPosGui%, %randomName%
IniFile := A_ScriptDir "\data\config.ini"
return

OpenConfig:
Run, notepad.exe "%IniFile%"
return



Start:
    ; Получаем путь к текущему скрипту
    scriptPath := A_ScriptDir
    ; Получаем имя текущего скрипта
    currentScript := A_ScriptName
	
    ; Подсчитываем количество файлов в папке
    fileCount := 0
    Loop, %scriptPath%\*
    {
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            fileCount++
        }
    }

    ; Проверка: если файлов больше 10, выводим ошибку
    if (fileCount > 10)
    {
        MsgBox, 16, Error, Too many files in the folder! (More than 10 files)
        return
    }
	
    ; Извлекаем все файлы в директории
    Loop, %scriptPath%\*
    {
        ; Пропускаем текущий скрипт
        if (A_LoopFileName != currentScript)
        {
            ; Запускаем файл
            Run, %A_LoopFileFullPath%
        }
    }
	ExitApp
return

HashChanger:
MsgBox 0x1, ,Изменить Hash всех файлов в папке?
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
    ; Получаем путь к текущему скрипту
    scriptPath := A_ScriptDir
    ; Получаем имя текущего скрипта
    currentScript := A_ScriptName

    ; Подсчитываем количество файлов в папке
    fileCount := 0
    Loop, %scriptPath%\*.ahk
    {
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            fileCount++
        }
    }

    ; Проверка: если файлов больше 10, выводим ошибку
    if (fileCount > 10)
    {
        MsgBox, 16, Error, Too many files in the folder! (More than 10 files)
        return
    }

    ; Перебираем файлы и изменяем содержимое
    Loop, %scriptPath%\*.ahk ; Можно указать любые расширения файлов, которые вы хотите изменять
    {
        ; Пропускаем текущий скрипт
        if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) ; Проверяем, что это не директория
        {
            ; Читаем содержимое файла
            FileRead, FileReadOutputVar1, %A_LoopFileFullPath%
            
            ; Генерируем случайное количество символов от 20 до 30
            Random, rand1488, 20, 30
            GenerateRandom := GenerateRandomName(rand1488)
            
            ; Регулярное выражение для замены
            1RepFile1 = AntiVACHashChanger:="\w*"
            2RepFile2 = AntiVACHashChanger:="%GenerateRandom%%GenerateRandom%%GenerateRandom%%GenerateRandom%"
            
            ; Выполняем замену
            RegExRepFile1 := RegExReplace(FileReadOutputVar1, 1RepFile1, 2RepFile2)
            
            ; Перезаписываем файл с новыми данными
            FileEncoding, UTF-8
            FileDelete, %A_LoopFileFullPath%
            FileAppend, %RegExRepFile1%, %A_LoopFileFullPath%
        }
    }
	MsgBox,,, Hash changing process completed, 1
return

NameChanger:
MsgBox 0x1, ,Изменить имена всех файлов в папке?
IfMsgBox OK, {
} Else IfMsgBox Cancel, {
Return
}
; Основной скрипт
scriptPath := A_ScriptDir ; Путь к текущему скрипту
currentScript := A_ScriptName ; Имя текущего скрипта

; Переименовываем файлы в директории
Loop, %scriptPath%\* ; Проходим по всем файлам в директории
{
    ; Пропускаем текущий скрипт
    if (A_LoopFileName != currentScript && !A_LoopFileAttrib.Contains("D")) { ; Проверяем, что это не директория
        fileNameWithoutExt := RegExReplace(A_LoopFileName, "\..*$") ; Убираем расширение файла
        fileExt := A_LoopFileExt ; Сохраняем расширение
        randomPrefix := GenerateRandomPrefix()
        if (StrLen(fileNameWithoutExt) > 5) {
            modifiedName := ModifyFileName(fileNameWithoutExt) ; Изменяем каждый третий символ на цифру
            newName := randomPrefix . modifiedName ; Собираем новое имя
        } else {
            newName := randomPrefix
        }
        newPath := scriptPath "\" newName "." fileExt
        FileMove, %A_LoopFileFullPath%, %newPath%
    }
}
	MsgBox,,, All files renamed except for this script, 1
return

UpCfg:
    FileSelectFile, selectedFile, 3, %A_ScriptDir%, Выберите файл config.ini, INI (*.ini)
    if selectedFile =
        return
    if (FileExist(selectedFile) && RegExMatch(selectedFile, "config\.ini$") = 0)
    {
        MsgBox,,, Выбранный файл не является "config.ini",1
        return
    }
    newFilePath := A_ScriptDir "\data\config.ini"
    IniRead, sections, %selectedFile%, ,
    Loop, Parse, sections, `n
    {
        section := A_LoopField
        IniRead, keys, %selectedFile%, %section%
        Loop, Parse, keys, `n
        {
            keyArray := StrSplit(A_LoopField, "=")
            if (keyArray.MaxIndex() = 2) ; Проверить, была ли строка успешно разделена
            {
                paramName := keyArray[1]
                paramValue := keyArray[2]
                IniWrite, %paramValue%, %newFilePath%, %section%, %paramName%
            }
            else
            {
                MsgBox,,, Неправильный формат строки в файле: %selectedFile%
                continue
            }
        }
    }
    MsgBox,,, Настройки импортированы,1
return



; Функция для генерации первых 5 случайных символов
GenerateRandomPrefix() {
    characters := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    randomPrefix := ""
    Loop, 5 {
        randomPrefix .= SubStr(characters, Random(1, StrLen(characters)), 1)
    }
    return randomPrefix
}

ModifyFileName(name) {
    newName := ""
    ; Получаем длину имени
    length := StrLen(name)
    
    Loop, %length% {
        index := A_Index
        char := SubStr(name, index, 1)
        
        ; Проверяем, является ли индекс третьим символом (т.е. 3, 6, 9 и т.д.)
        if (Mod(index, 4) = 0 && index > 5) { 
            ; Заменяем на случайную цифру
            randomDigit := Random(0, 9)
            newName .= randomDigit
        } else {
            newName .= char
        }
    }

    return newName
}

Random(min, max) {
    Random, rand, min, max
    return rand
}










Exit:
    Gui, Destroy
    ExitApp
return

GuiClose:
    ExitApp
return
MetkaMenu3:
Run, notepad.exe "%A_ScriptFullPath%"
return

*~$Home::
MetkaMenu2:
Reload
return

*~$End::
MetkaMenu1:
ExitApp
return

; Функция для генерации случайного имени
GenerateRandomName(length) {
    chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    name := ""
    Loop, %length%
    {
        Random, index, 1, StrLen(chars)
        name .= SubStr(chars, index, 1)
    }
    return name
}
