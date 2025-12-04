#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* strip(char* s) {
    while (isspace(*s)) s++;

    char* end = s + strlen(s) - 1;
    while (end > s && isspace(*end)) end--;
    end[1] = '\0';

    return s;
}

int is_paper(char** arr, size_t rows, size_t x, size_t y) {
    if (y >= rows) return 0;
    if (x >= strlen(arr[y])) return 0;
    return arr[y][x] == '@' ? 1 : 0;
}

int papers(char** arr, size_t rows, size_t x, size_t y) {
    int num = 0;
    for (int i = -1; i < 2; i++) {
        for (int j = -1; j < 2; j++) {
            if (i == 0 && j == 0) continue;
            if (is_paper(arr, rows, x+i, y+j)) num++;
        }
    }
    return num;
}

void puzzle(char** lines, size_t rows, long* p1, long* p2) {
    *p1 = 0;
    *p2 = 0;

    for (size_t y = 0; y < rows; y++) {
        char* str = lines[y];

        for (size_t x = 0; x < strlen(str); x++) {
            if (str[x] != '@' || papers(lines, rows, x, y) >= 4) continue;
            *p1 = *p1 + 1;
        }
    }

    while (1) {
        int c = 0;
        for (size_t y = 0; y < rows; y++) {
            char* str = lines[y];

            for (size_t x = 0; x < strlen(str); x++) {
                if (str[x] != '@' || papers(lines, rows, x, y) >= 4) continue;
                str[x] = '.';
                c++;
            }
        }

        if (c == 0) break;
        *p2 = *p2 + c;
    }
}

int main() {
    FILE* file = fopen("input", "r");
    if (!file) return 1;

    char** lines = NULL;
    size_t rows = 0;
    char* line = NULL;
    size_t cap = 0;

    while (getline(&line, &cap, file) != -1) {
        line = strip(line);

        lines = realloc(lines, (rows + 1) * sizeof(*lines));
        lines[rows] = strdup(line);

        rows++;
    }

    free(line);
    fclose(file);

    long p1, p2;
    puzzle(lines, rows, &p1, &p2);

    printf("%ld\n", p1);
    printf("%ld\n", p2);
}
