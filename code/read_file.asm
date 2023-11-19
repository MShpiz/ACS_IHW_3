.include "macrolib.s"
.global read_from_file

read_from_file:
# Чтение текста из файла, задаваемого в диалоге, в буфер фиксированного размера
.eqv    NAME_SIZE 256	# Размер буфера для имени файла
    .data
prompt:         .asciz "Enter file path: "     # Путь до читаемого файла
incorrect_file:	.asciz	"Incorrect file name"
incorrect_read:	.asciz	"Incorrect read operation"

file_name:      .space	NAME_SIZE		# Имячитаемого файла

.text
    push(ra)
    push(s0)
    push(s1)
    push(s2)
    push(s3)
    mv	s1, a0
    mv	s2, a1
    addi	s2, s2, -1 # make place for \0
    ###############################################################
    # Вывод подсказки
    # Ввод имени файла с консоли эмулятора
    la	a0, prompt
    la	a1 file_name
    li  a2 NAME_SIZE
    li  a7 54
    ecall
    # Убрать перевод строки
    li	t4 '\n'
    la	t5	file_name
loop:
    lb	t6  (t5)
    beq t4	t6	replace
    addi t5 t5 1
    b	loop
replace:
    sb	zero (t5)
    ###############################################################
    li   	a7 1024     	# Системный вызов открытия файла
    la      a0 file_name    # Имя открываемого файла
    li   	a1 0        	# Открыть для чтения (флаг = 0)
    ecall             		# Дескриптор файла в a0 или -1)
    li		t0 -1			# Проверка на корректное открытие
    beq		a0 t0 er_name	# Ошибка открытия файла
    mv   	s0 a0       	# Сохранение дескриптора файла
    ###############################################################
    # Чтение информации из открытого файла
    li   a7, 63       # Системный вызов для чтения из файла
    mv   a0, s0       # Дескриптор файл
    mv a1, s1   # Адрес буфера для читаемого текста
    mv a2 s2 # Размер читаемой порции
    
    ecall             # Чтение
    # Проверка на корректное чтение
    beq		a0 s1 er_read	# Ошибка чтения
    mv   	s3 a0       	# Сохранение длины текста
    ###############################################################
    # Закрытие файла
    li   a7, 57       # Системный вызов закрытия файла
    mv   a0, s0       # Дескриптор файла
    ecall             # Закрытие файла
    ###############################################################
    # Установка нуля в конце прочитанной строки
    mv	t0 s1	 # Адрес начала буфера
    add t0 t0 s3	 # Адрес последнего прочитанного символа
    sub a0, t0, s1
    
    addi t0 t0 1	 # Место для нуля
    addi a0 a0 1
    sb	zero (t0)	 # Запись нуля в конец текста  
    
    end_read:
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret
    
 er_name:
    # Сообщение об ошибочном имени файла
    	la	a0, incorrect_file
	li	a1, 2
	li 	 a7 55
	ecall
	li	a0, -1
	jal end_read
er_read:
    # Сообщение об ошибочном чтении
	la	a0, incorrect_read
	li	a1, 2
	li 	 a7 55
	ecall
    li	a0, -1
    jal end_read
