#include <stdio.h>
#include <string.h>

void encode(char [], char [], char [], int);

int main()
{
   char str1[60] = "th3 fitn-ssgram pacer test is a multistage aerobic";
   char str2[60] = "capacity test that progre/sively gets more difficult as it";
   char str3[60] = "continues stop the twenty meter pacer test will begin in";

   char key1[35] = "how do you know of the key";
   char key2[35] = "break this bitch";

   char e[60];
   char d[60];

   printf("\nTesting key1:  %s\n", key1);
   printf("---------------------------\n");
   printf("original :  %s\n", str1);
   encode(str1, e, key1, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key1, 1);
   printf("  decoded:  %s\n", d);
  
   printf("\nTesting key2:  %s\n",key2);
   printf("------------------------------------\n");
   printf("original :  %s\n", str1);
   encode(str1, e, key2, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key2, 1);
   printf("  decoded:  %s\n", d);
  
   printf("\nTesting key1:  %s\n", key1);
   printf("---------------------------\n");
   printf("original :  %s\n", str2);
   encode(str2, e, key1, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key1, 1);
   printf("  decoded:  %s\n", d);

   printf("\nTesting key2:  %s\n",key2);
   printf("------------------------------------\n");
   printf("original :  %s\n", str2);
   encode(str2, e, key2, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key2, 1);
   printf("  decoded:  %s\n", d);

   printf("\nTesting key1:  %s\n",key1);
   printf("---------------------------\n");
   printf("original :  %s\n", str3);
   encode(str3, e, key1, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key1, 1);
   printf("  decoded:  %s\n", d);

   printf("\nTesting key2:  %s\n",key2);
   printf("------------------------------------\n");
   printf("original :  %s\n", str3);
   encode(str3, e, key2, 0);
   printf("  encoded:  %s\n", e);
   encode(e, d, key2, 1);
   printf("  decoded:  %s\n", d);

   return 0;
}
