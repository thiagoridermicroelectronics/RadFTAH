#define COL_NUM 8
#define CPU_NUM 2

/*void uart_print(char *string){

	// Index variable
	int i;

	// Pointer to tx fifo
	unsigned int * uart_tx = (unsigned int *) 0x4400;

	// Until end of string send to uart
	for(i=0; i < 10 && string[i] != '\0'; i++)
		uart_tx[0] = string[i];
}*/

unsigned int get_time(void){

	asm("mfc0 $2,$18");

}

void print_space(void){
	unsigned int * uart_tx = (unsigned int *) 0x4400;
	uart_tx[0] = 0x20;
}

void print_newline(void){
	unsigned int * uart_tx = (unsigned int *) 0x4400;
	uart_tx[0] =0xA;
	uart_tx[0] =0xD;
}

unsigned int adivb(unsigned int a, unsigned int b){
	unsigned int res = 0;
	if (b) {
		while (a >= b){
			res++;
			a = a -b;
		}
	}
	return res;
}

void print_uint(unsigned int number){
	unsigned int * uart_tx = (unsigned int *) 0x4400;
	unsigned int tmp;
	unsigned int i = 1;

	tmp = adivb(number, 1000000000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*1000000000;

	tmp = adivb(number, 100000000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*100000000;

	tmp = adivb(number, 10000000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*10000000;

	tmp = adivb(number, 1000000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*1000000;

	tmp = adivb(number, 100000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*100000;

	tmp = adivb(number, 10000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*10000;

	tmp = adivb(number, 1000);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*1000;

	tmp = adivb(number, 100);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*100;

	tmp = adivb(number, 10);
	uart_tx[0] = tmp + 0x30;
	number = number - tmp*10;

	uart_tx[0] = number + 0x30;

}

void print_start(int cpu_id, unsigned int time){
	unsigned int * uart_tx = (unsigned int *) 0x4400;
	uart_tx[0] =0x53;
	uart_tx[0] =0x74;
	uart_tx[0] =0x61;
	uart_tx[0] =0x72;
	uart_tx[0] =0x74;
	uart_tx[0] =0x69;
	uart_tx[0] =0x6e;
	uart_tx[0] =0x67;
	uart_tx[0] =0x20;
	uart_tx[0] =0x63;
	uart_tx[0] =0x6f;
	uart_tx[0] =0x64;
	uart_tx[0] =0x65;
	uart_tx[0] =0x20;
	uart_tx[0] =0x6f;
	uart_tx[0] =0x6e;
	uart_tx[0] =0x20;
	uart_tx[0] =0x43;
	uart_tx[0] =0x50;
	uart_tx[0] =0x55;
	uart_tx[0] =0x23;
	print_uint(cpu_id);
	print_newline();
	print_uint(time);
	print_newline();
}

void print_end(int cpu_id, unsigned int time){
	unsigned int * uart_tx = (unsigned int *) 0x4400;

	uart_tx[0] =0x46;
	uart_tx[0] =0x69;
	uart_tx[0] =0x6e;
	uart_tx[0] =0x69;
	uart_tx[0] =0x73;
	uart_tx[0] =0x68;
	uart_tx[0] =0x65;
	uart_tx[0] =0x64;
	uart_tx[0] =0x20;
	uart_tx[0] =0x70;
	uart_tx[0] =0x72;
	uart_tx[0] =0x6f;
	uart_tx[0] =0x63;
	uart_tx[0] =0x65;
	uart_tx[0] =0x73;
	uart_tx[0] =0x73;
	uart_tx[0] =0x69;
	uart_tx[0] =0x6e;
	uart_tx[0] =0x67;
	uart_tx[0] =0x20;
	uart_tx[0] =0x6f;
	uart_tx[0] =0x6e;
	uart_tx[0] =0x20;
	uart_tx[0] =0x43;
	uart_tx[0] =0x50;
	uart_tx[0] =0x55;
	uart_tx[0] =0x23;
	print_uint(cpu_id);
	print_newline();
	print_uint(time);
	print_newline();
}

void print_matrix(unsigned int * matrix){//unsigned int matrix[COL_NUM][COL_NUM]){

	int i, j;
	unsigned int tmp;
	print_newline();
	for (i=0; i<COL_NUM; i++){
		for (j=0; j<COL_NUM; j++){
			tmp = matrix[i+j*COL_NUM];
			print_uint(tmp);
			print_space();
		}
		print_newline();
	}
	print_newline();
	print_newline();
}

int main(unsigned int cpu_id)
{

	unsigned int * table = (unsigned int *) (0x4100);
	unsigned int * res   = (unsigned int *) (0x4100 + 4*(COL_NUM*COL_NUM));
	unsigned int i,j,k;
	unsigned int start_time, end_time;

	unsigned int * sem = (unsigned int *) 0x4000;

	if (cpu_id == 0){
		// Initializes matrix
		for (i=0; i<COL_NUM; i++){
			for (j=0; j<COL_NUM; j++){
				table[i+j*COL_NUM] = i+j;
			}
		}
	}

	if (cpu_id == 0) {
		//print_matrix(table);
		sem[8*CPU_NUM-1] = 0x1;
	}

	while (sem[8*CPU_NUM-1] == 0){
		for (i=0; i<10; i++){
			asm("nop");
		}
	}

	start_time = get_time();

	// Compute table*table acc. to processor number and processor id
//	for(i = cpu_id*COL_NUM/CPU_NUM; i< (cpu_id+1)* COL_NUM/CPU_NUM;i++){
//		for(j=0;j<COL_NUM;j++){
//			res[i+j*COL_NUM]=0;
//			for(k=0;k<COL_NUM;k++){
//				res[i+j*COL_NUM]+=table[i+k*COL_NUM]*table[k+j*COL_NUM];
//			}
//		}
//	}

	for(j = cpu_id*COL_NUM/CPU_NUM; j< (cpu_id+1)* COL_NUM/CPU_NUM;j++){
		for(i=0;i<COL_NUM;i++){
			res[i+j*COL_NUM]=0;
			for(k=0;k<COL_NUM;k++){
				res[i+j*COL_NUM]+=table[i+k*COL_NUM]*table[k+j*COL_NUM];
			}
		}
	}

	sem[8*cpu_id] = 0x1;
	end_time = get_time();

	if (cpu_id == 0) {
		// Print start message
		print_start(cpu_id, start_time);
		// Print end message
		print_end(cpu_id, end_time);
		sem[8*cpu_id] = 0x2;
	}else{
		while(sem[8*(cpu_id - 1)] != 0x02){
			for (i=0; i<10; i++){
				asm("nop");
			}
		}
		// Print start message
		print_start(cpu_id, start_time);
		// Print end message
		print_end(cpu_id, end_time);
		sem[8*cpu_id] = 0x2;
	}

	if (cpu_id == 0) {
		while(sem[8*(CPU_NUM - 1)] != 0x02){
			for (i=0; i<10; i++){
				asm("nop");
			}
		}
		// Print result
		//print_matrix(res);
	}

	return 0;

}
