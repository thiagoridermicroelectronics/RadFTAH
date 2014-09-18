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
   unsigned int tmp, tmp2, valid = 1;
   // Write coe header
   fprintf(out,"memory_initialization_radix=16;\n");
   fprintf(out,"memory_initialization_vector=\n");
   valid = fread(&tmp, 4, 1, in);
   while (valid) {
      // Swap bytes
      tmp2 = (tmp & 0xFF) << 24;
      tmp2 = tmp2 + ((tmp & 0xFF00) << 8);
      tmp2 = tmp2 + ((tmp & 0xFF0000) >> 8);
      tmp2 = tmp2 + ((tmp & 0xFF000000) >> 24);
      valid = fread(&tmp, 4, 1, in);
      if (valid)
         fprintf(out,"%0.8X,\n", tmp2);
      else
         fprintf(out,"%0.8X;", tmp2);
   }
   fclose(in);
   fclose(out);

  return 0;
}
