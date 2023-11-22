# ИДЗ по АВС №3
  
**Вариант:** 16 \
**Выполнила:** Панфилова Мария Денисовна \
**Группа:** БПИ226

## Текст варианта
Разработать программу, которая вычисляет количество цифр и букв в заданной ASCII–строке. Вывод результатов организовать в файл (используя соответствующие преобразования чисел в строки).
## Решение на 10

• Программа разбита на несколько единиц компиляции. При этом подпрограммы ввода–вывода составляют унифицированные модули, используемые повторно как в программе, осуществляющей ввод исходных данных, так и в программе, осуществляющей тестовое покрытие. \
• Макросы выделены в отдельную автономную библиотеку

## Решение на 9
• В программу добавлено использование макросов для реализации ввода, вывода, и обработки данных. Макросы поддерживают повторное использование с различными параметрами. Внутри макросов расположены вызовы соответствующих подпрограмм. \
• Реализована дополнительная [тестовая программа](https://github.com/MShpiz/ACS_IHW_3/blob/main/code/test_with_macros.asm), которая вызывает выполняемые подпрограммы через макросы, реализуя ту же функциональность, что и основная [тестовая программа](https://github.com/MShpiz/ACS_IHW_3/blob/main/code/test.asm).


## Решение на 8
• Добавлена в программу возможность дополнительного вывода результатов на консоль. Выводить или нет решает пользователь отвечая «Y» или «N» на соответствующий вопрос компьютерной программы. Вывод программы при этом полностью соответствует тому что было бы выведено в файл (при выводе результатов в консоль результаты не записываются в файшл). \
• Реализована дополнительная [тестовая программа](https://github.com/MShpiz/ACS_IHW_3/blob/main/code/test.asm), которая осуществляет многократный вызов процедур, обеспечивающих ввод файлов, их обработку и вывод для различных исходных данных, расположенных в каталоге с исходными [тестовыми данными](https://github.com/MShpiz/ACS_IHW_3/tree/main/code/test_files).

## Решение на 6-7
• Внутри функций используются регистровые или локальные (при нехватке) переменные. \
• Для чтения текста из файла реализован буфер ограниченного размера, равного 512 байтам. При этом программа читает файлы размером до 10 килобайт. Программа может читать файлы размером более 10 КБ и корректно обрабатывать строки.\
• Реализован [ввод исходных данных](), их [обработка](), [вывод результатов]() через соответствующие подпрограммы. Подпрограммы получают необходимые им данные через параметры в соответствии с принятым соглашением о передаче параметров. \
• Возвращаемые из подпрограмм значения возвращаются через параметры в соответствии с общепринятыми соглашениями.
## Решение на 4-5 
• Приведено решение программы на ассемблере (исходный код в папке [code](https://github.com/MShpiz/ACS_IHW_3/tree/main/code)). Программа из файла, относительный адрес к которому получен от пользователя, читает данные. Результаты записываются в другой файл, относительный адрес к которому получен от пользователя. \
• Все изменяемые параметры программы вводятся через диалоговые окна. \
• В программе присутствуют комментарии, поясняющие выполняемые ей действия. \
• Обработка данных, полученных из файла сформирована в виде отдельной [подпрограммы](https://github.com/MShpiz/ACS_IHW_3/blob/main/code/count_letters_digits.asm). \
• В [подкаталоге данных](https://github.com/MShpiz/ACS_IHW_3/tree/main/code/test_files) присутствуют файлы, используемые для тестирования. \
• ~~Буфер для текста программы имеет фиксированный размер размером не менее 4096 байт, допускающий ввод без искажений только тексты, ограниченные этим размером.~~ 
> отменено требованиями на 6-7 

• При чтении файла размером, превышающим размер буфера, не происходит падение программы. Программа корректно обработает введенный «урезанный» текст. \
• Сформирован отчет с результатами тестовых прогонов и описанием используемых опций компиляции, проведенных модификаций ассемблерной программы. \
• Для корректного выполнения программы используются такие настройки RARS: <img width="243" alt="Безымянный" src="https://github.com/MShpiz/ACS_IHW_3/assets/88736099/dfb5d3cd-03f1-4bec-844c-85dd6559e0c1">




## Тестирование
• Результаты тестовых прогонов записываются в папку [code/test_results](https://github.com/MShpiz/ACS_IHW_3/tree/main/code/test_results) в файлы с соответствующим номером.
| № |файл с исходным текстом| количество букв | количество цифр | Ошибки| 
|--- | --- | --- | ---|--|
|1| meow |0|0|файл с таким имененм не найден|
|2| test_files/empty.txt |0|0|✔|
|3| test_files/small_text.txt |36|8|✔|
|4| test_files/long_text.txt |364|147|✔|
|5| test_files/longer_than_buffer.txt |468|0|✔|
|6| test_files/10+kb_file.txt |418|0|✔|


Котити закончились так что вот вам мем:
![ggwtuq2](https://github.com/MShpiz/ACS_IHW_3/assets/88736099/88f6d07c-f6f3-49b0-b48d-dc9096a721db)

