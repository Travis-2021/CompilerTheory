filename = lexer
.PHONY:$(filename),test
$(filename):
	flex $(filename).l
	gcc lex.yy.c -o $(filename)
	
clean:
	-rm lex.yy.c
	-rm $(filename)
	-rm test.out
test:
	./$(filename) < test.c > test.out