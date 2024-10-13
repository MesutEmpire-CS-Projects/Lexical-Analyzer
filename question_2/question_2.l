%{
#include <stdio.h>
%}

verb (is|am|are|were|was|be|being|been|do|does|did|will|would|should|can|could|has|have|had|go)
delim [ \t\n]
ws {delim}+

%%
{ws} {}
(^|[^a-zA-Z]){verb}([^a-zA-Z]|$) {printf("Recognized verb : %s\n",yytext);}
. {
    printf("Unknown: %s\n", yytext);
}

%%
int main(int argc, char *argv[]){
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
 fclose(fptr);
return 0;
}