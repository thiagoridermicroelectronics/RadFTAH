

#include <stdio.h>

int main(int argc, char *argv[])
{
   // check args
   if (argc != 3){
      printf("\nUsage bin2hex <input> <output>\n");
      return 0;
   }

   // Open/create files
   FILE *in, *out;
   in  = fopen(argv[1],"rb");
   out = fopen(argv[2],"wt");

   // Read binary file and write to text file
   unsigned int tmp, tmp2;
   //fread(&tmp, 4, 1, in);
   while (fread(&tmp, 4, 1, in)) {
      tmp2 = (tmp & 0xFF) << 24;
      tmp2 = tmp2 + ((tmp & 0xFF00) << 8);
      tmp2 = tmp2 + ((tmp & 0xFF0000) >> 8);
      tmp2 = tmp2 + ((tmp & 0xFF000000) >> 16);
      fprintf(out,"%0.8X\n", tmp2);

   }
//     strcpy(stuff,"This is an example line.");
//     for (index = 1; index <= 10; index++)
//     	fprintf(fp,"%s Line number %d\n", stuff, index);
   fclose(in);
   fclose(out);


//    int i;
//    for (i=0;i<=argc;i++)
//    {
//      cout<<"argv["<<i<<"]: "<<argv[i]<<endl;
//
//    }*/
  return 0;
}
