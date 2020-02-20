// Zach Lindler (zelindl)
// CPSC 2310-2
// Assignement 2
// 10/25/19

// This program shows the machine steps of multiplying two binary numbers
// passed in as integers.

#include <iostream>
#include <cmath>
#include <string>
#include <cstdio>
using namespace std;

string convertBinary(int num);

void printDivider(void);

int main(void){
   
   //declare multiplicand and multiplier variables.
   int multiplicand, multiplier;

   //get the two variables from cin.
   cout << "Please enter two integers from 0 to 255, inclusive: ";
   cin >> multiplicand >> multiplier;

   //range checking
   if(multiplicand < 0 || multiplicand > 255){
	  cout<<"Error, multiplicand is not in specified range."<<endl;
	  return 1;
   }
	  
   if(multiplier < 0 || multiplier > 255){
	  cout<<"Error: multiplier is not in specified range."<<endl;
	  return 1;
   }

   //print both values
   cout << endl << "multiplicand: " << multiplicand << endl;
   cout << "multiplier: " << multiplier << endl << endl;
   
   //initialize accumulator and carry
   int acc = 0;
   int carry = 0;
   int mdr = 0;
   int mq = 0;

   cout << "c and acc set to 0" << endl;

   //create two variables to hold the binary values for the multiplicand
   //and multiplier. Then, print them out.
   string bMultiplicand = convertBinary(multiplicand);
   string bMultiplier = convertBinary(multiplier);

   mq = multiplier;
   mdr = multiplicand;

   cout << "mq set to multiplier\t= " << multiplier << " decimal and ";
   cout << bMultiplier << " binary" << endl;
   cout << "mdr set to multiplicand\t= " << multiplicand << " decimal and ";
   cout << bMultiplicand << " binary" << endl;

   printDivider();

   //create binary strings for the MDR, MQ, and ACC.
   string bMDR, bMQ, bACC;

   for(int i=1; i<=8; i++){
	  
	  //convert the MDR, MQ, and ACC to binary and print them out.
	  bMDR = convertBinary(mdr);
	  bMQ = convertBinary(mq);
	  bACC = convertBinary(acc);

	  cout << "step " << i << ":   " << carry << " " << bACC << " " << bMQ << endl;

	  //determine add based on least significant bit
	  if(bMQ[7] == '1'){
		 cout << "        +   " << bMDR << "        ^";
		 cout << "add based on lsb=1" << endl;
		 cout << "          ----------" << endl;
		 acc += multiplicand;
		 if(acc > 255){carry = 1;}
	  }
	  else{
		 cout << "        +   " << bMDR << "        ^";
		 cout << "no add based on lsb=0" << endl;
		 cout << "          ----------" << endl;
	  }

	  //print the carry, ACC, and MQ.
	  cout << "          " << carry << " " << bACC << " " << bMQ << endl;
	  cout << "       >>                     shift right" << endl;
	  
	  //shift right
	  mq = mq>>1;
	  if(bACC[7] == '1'){mq += 128;}
	  acc = acc>>1;
	  carry = 0;

	  bMDR = convertBinary(mdr);
	  bMQ = convertBinary(mq);
	  bACC = convertBinary(acc);

	  cout << "          " << carry << " " << bACC << " " << bMQ << endl;
	  
	  printDivider();

   }

   //calculate the solutions
   string bSolution = bACC + bMQ;
   int solution = 0;
   for(int i=7; i>=0; i--){
	  if(bSolution[i-1] == '1'){
		 solution += pow(2, 7-i);
	  }
   }

   //print the final part of the output
   cout << "check:                binary   decimal" << endl;
   cout << "                    " << bMultiplicand;
   printf("% 10i\n", multiplicand);
   cout << "             x      " << bMultiplier;
   printf("  x%7i\n", multiplier);
   cout << "             ----------------   ------" << endl;
   cout << "            " << bSolution;
   printf("%10i\n", solution);

   return 0;
}


//this function converts an integer number to a binary string
string convertBinary(int num){
   string bin;
   for(int i = 7; i>=0; i--){
	  if((num>>i) & 1){bin.push_back('1');}
	  else{bin.push_back('0');}
   }

   return bin;
}

//this function prints the divider line between steps in the output.
void printDivider(void){
   for(int i=0; i<=50; i++){cout<<"-";}
   cout<<endl;
}
