#include <iostream>
#include <stdlib.h>
#include <fstream>
#include <vector> 
using namespace std;

vector<long> readFromFile(string filename)
{
  string line;
  ifstream myfile(filename);
  vector<long> numbers(0);
  if (myfile.is_open())
  {
    while ( getline(myfile,line) )
    {
      long number = stol(line);
      numbers.push_back(number);
    }
    myfile.close();
  }
  return numbers;
}

bool isSumOfTwo(int index, int window, vector<long> numbers){
  int start = index - window;
  int end = index;
  long searchedNumber = numbers[index];

  for(int i=start;i<end;i++){
    for(int j=start;j<end;j++){
      if(i!=j&&numbers[i]+numbers[j]==searchedNumber) return true;
    }
  }

  return false;
}

void findSet(long searchedNumber, vector<long> numbers){
  for(int i=0;i<numbers.size();i++){
    long sum = 0;
    long count = 0;
    long* smallest = NULL;
    long* largest = NULL;

    for(int j=i;j<numbers.size();j++){
      long current=numbers[j];
      if(smallest==NULL || current < *smallest) smallest = new long(current);
      if(largest==NULL || current > *largest) largest = new long(current);
      sum += current;
      count += 1;
      if(count > 1 && sum == searchedNumber){
        cout << "Smallest: " << *smallest << ", Largest: " << *largest << "\n";
        long result = *smallest + *largest;
        cout << "Result: " << result;
        return;
      }
      if(sum > searchedNumber) break;
    }
  }
}

int main() {
  vector<long> numbers = readFromFile("input.txt");
  int window = 25;

  for(int i=window;i<numbers.size();i++){
    if(!isSumOfTwo(i, window, numbers)){
      cout << "First number: " << numbers[i] << "\n";
      findSet(numbers[i], numbers);
      break;
    }
  }

  return 0;
}
