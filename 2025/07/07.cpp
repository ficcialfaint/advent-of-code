#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

vector<string> read_lines(string fileName) {
    vector<string> lines;
    ifstream file(fileName);
    string line;

    while (getline(file, line)) {
        lines.push_back(line);
    }

    file.close();
    return lines;
}

void puzzle(vector<string>* lines, long* p1, long* p2) {
    bool first = 1;
    vector<long> paths((*lines)[0].size());

    for (int i = 0; i < lines->size(); i++) {
        string &line = (*lines)[i];

        if (first) {
            replace(line.begin(), line.end(), 'S', '|');
            paths[line.find('|')] = 1;
            first = false;
            continue;
        }

        string &prev_line = (*lines)[i-1];

        for (int j = 0; j < line.length(); j++) {
            if (prev_line[j] != '|') continue;

            if (line[j] == '.') {
                line[j] = '|';
                continue;
            }

            if (line[j] == '^') {
                if (j != 0) {
                    paths[j-1] += paths[j];
                    line[j-1] = '|';
                }

                if (j != line.length()-1) {
                    paths[j+1] += paths[j];
                    line[j+1] = '|';
                }

                *p1 += (j != 0) || (j != line.length()-1);
                paths[j] = 0;
            }
        }
    }

    for (long num : paths) *p2 += num;
}

int main() {
    vector<string> lines = read_lines("input");
    long p1 = 0, p2 = 0;

    puzzle(&lines, &p1, &p2);

    cout << p1 << endl;
    cout << p2 << endl;

    return 0;
}
