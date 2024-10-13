%{
#include <stdio.h>
#include <ctype.h>

int word_count = 0;
int total_size = 0;
%}

%%

[a-zA-Z]+    { word_count++; total_size += yyleng; } /* Count words and sum their lengths */
[^a-zA-Z]+   { }

%%

int main(int argc, char *argv[]) {
    FILE *fptr;

    if (argc < 2) {
        perror("Enter the file name");
        return 1;
    }

    fptr = fopen(argv[1], "r");

    if (fptr == NULL) {
        perror("Failed to open file");
        return 1;
    }

    yyin = fptr;
    yylex();
    printf("\nTotal words: %d\n", word_count);
    printf("\nTotal size of words: %d\n", total_size);
    fclose(fptr);

    return 0;
}
