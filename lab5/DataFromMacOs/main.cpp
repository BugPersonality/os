#include <iostream>
#include <fstream>
#include <vector>
using namespace std;

int main(int argc, const char * argv[]) {
    
    ofstream output("report.log");
    
    int count = 0;
    
    while (true){
        count++;
        malloc(100);
        if (count % 10000 == 0){
            output << count << endl;
        }
    }
    return 0;
}
