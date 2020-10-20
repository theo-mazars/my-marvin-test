##
## EPITECH PROJECT, 2020
## B-DOP-500-LYN-5-1-mymarvin-theo.mazars
## File description:
## Makefile
##

LD				=	@ld
CC				=	gcc
DIROBJ			=	bin
EXTENSION		=	.c

NAME	=	my_marvin
SOURCES	=	src
OBJDIR	=	bin
SRC		+=	$(wildcard $(addprefix $(SOURCES)/, *)$(EXTENSION))
SRC		+=	$(wildcard $(addprefix $(SOURCES)/**/, *)$(EXTENSION))
OBJ		=	$(patsubst src/%,bin/%.o,$(basename $(SRC)))

SRC-CRIT		=	$(wildcard $(addprefix tests/, *)$(EXTENSION))
OBJ-CRIT		=	$(SRC-CRIT:$(EXTENSION)=.o)

CPPFLAGS		+=	-Wall -Wextra -fPIC
LDFLAGS			+=	-g3
CFLAGS			+=	-Iinclude -fno-builtin -g3
CXXFLAGS		+=	-IInclude -fno-builtin
CRITFLAGS		=	-lcriterion --coverage

END				=	\033[0m
BOLD			=	\033[1m
GREY			=	\033[30m
RED				=	\033[31m
GREEN			=	\033[32m
YELLOW			=	\033[33m
BLUE			=	\033[34m
PURPLE			=	\033[35m
CYAN			=	\033[36m
WHITE			=	\033[37m

all:	$(NAME)

$(NAME): $(OBJ)
	@$(CC) $(LDFLAGS) -o $(NAME) $(OBJ)
	@printf "$(GREEN)[DONE]\t$(shell echo $(SRC) | wc -w) Files compiled$(END)\n"

test:	$(OBJ-CRIT)
	@$(CC) $(CFLAGS) $(CRITFLAGS) $(OBJ-CRIT)
	@printf "$(GREEN)[DONE]\tCOMPLETED$(END)\n"
	./a.out

clean:
	@find . -type f \( -iname "*~" \) -delete
	@$(RM) $(OBJ)
	@$(RM) $(OBJ-CRIT)
	@printf "$(YELLOW)[DONE]\tCLEANED $(END)\n"

fclean:	clean
	@$(RM) -r $(DIROBJ)
	@$(RM) $(NAME)
	@$(RM) $(NAME) $(SERVER-NAME)

re:	fclean all

$(DIROBJ):
	@mkdir -p $(dir $(OBJ)) \
	&& printf "$(GREEN)[DONE]\t$(BLUE)Creating:$(WHITE)$(BOLD) binaries folder$(END)\n" \
	|| printf "$(RED)[FAIL]\tCan't create:$(BOLD) binaries folder$(END)\n"

$(OBJDIR)/%.o: $(SOURCES)/%$(EXTENSION) | $(DIROBJ)
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $< \
	&& printf "$(GREEN)[    ]\t$(BLUE)Compiling:$(WHITE)$(BOLD) %s$(END)\n" $< \
	|| printf "$(RED)[FAIL]\tCan't compile:$(BOLD) %s$(END)\n" $<

.PHONY: all test_run clean fclean re