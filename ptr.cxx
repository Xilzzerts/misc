#include <iostream>
#include <memory>
#include <vector>
using namespace std;

int main(void)
{
    vector<shared_ptr<char>> x;
    {
        shared_ptr<char> tmp = make_shared<char>('X');
        x.push_back(tmp);
    }
    cout << x[0].use_count() << " " << *(x[0]) <<  endl;
    return 0;
}
