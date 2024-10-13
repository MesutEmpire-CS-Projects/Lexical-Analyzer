%{
#include <stdio.h>
FILE *input_fptr, *output_fptr;
%}

%%

abc {fprintf(output_fptr,"ABC");}
[d-zA-Z]+ {fprintf(output_fptr,"%s",yytext);}
[^a-zA-Z]+ {fprintf(output_fptr,"%s",yytext);}

%%
int main(int argc, char *argv[]){

    if (argc < 3) {
        perror("Enter the input and output file names");
        return 1;
    }

    input_fptr = fopen(argv[1], "r");
    if (input_fptr == NULL) {
        perror("Failed to open input file");
        return 1;
    }

    output_fptr = fopen(argv[2], "w");
    if (output_fptr == NULL) {
        perror("Failed to open output file");
        fclose(input_fptr);
        return 1;
    }


 yyin = input_fptr;
yylex();
    fclose(input_fptr);
    fclose(output_fptr);
return 0;
}