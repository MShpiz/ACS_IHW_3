# variant 31
.include "macrolib.s"
.text
.global	main
main:
jal user_input_integral

# returned a - a0
# returned b t - a1
# returned begining of interval - a2
# returned end of interval - a3

fpush(fa0)
fpush(fa1)
fpush(fa2)
fpush(fa3)
# passing a as an argument - a0
# passing b as an argument - a1
# passing begining of interval as an argument - a2
# passing end of interval as an argument - a3

jal print_equation

fpop(fa3)	# passing end of interval as an argument
fpop(fa2)	# passing begining of interval as an argument
fpop(fa1)	# passing b as an argument
fpop(fa0)	# passing a as an argument
jal integrate			# result of integration returns in a0

jal print_result	# passing result of integration by a0
exit
