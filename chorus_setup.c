#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>

#define LEFT_ENABLE_OFFSET 0x0
#define LEFT_DELAY_OFFSET 0x4
#define LEFT_DELAY_OFFSET2 0x8
#define LEFT_GAIN_OFFSET 0xc
#define LEFT_VOLUME_OFFSET 0x10

#define RIGHT_ENABLE_OFFSET 0x14
#define RIGHT_DELAY_OFFSET 0x18
#define RIGHT_DELAY_OFFSET2 0x1c
#define RIGHT_GAIN_OFFSET 0x20
#define RIGHT_VOLUME_OFFSET 0x24

int main () {
	FILE *file;
	size_t ret;	
	uint32_t val;

	file = fopen ("/dev/chorus" , "rb+" );
	if (file == NULL) {
		printf("failed to open file\n");
		exit(1);
	}

	// Test reading the regsiters sequentially
	printf("\n***************\n* read initial register values\n***************\n\n");

	ret = fread(&val, 4, 1, file);
	printf("left_enable = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_phase_inc1 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_phase_inc2 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_gain = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_volume = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_enable = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_phase_inc1 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_phase_inc2 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_gain = 0x%x\n", val);
    
	//ret = fread(&val, 4, 1, file);
	//printf("empty register = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_volume = 0x%x\n", val);




	// Reset file position to 0
	ret = fseek(file, 0, SEEK_SET);
	printf("fseek ret = %d\n", ret);
	printf("errno =%s\n", strerror(errno));

	// Write to all registers using fseek
	printf("\n***************\n* write all registers with desired setup values \n***************\n\n");


	// todo:  Write desired values to all registers
	val = 0x0001;
	ret = fseek(file, LEFT_ENABLE_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("left_enable = 0x%x\n",val);

	val = 0x0001;
	ret = fseek(file, RIGHT_ENABLE_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("right_enable = 0x%x\n",val);


	val = 0x3;
	ret = fseek(file, LEFT_DELAY_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("left_phase_inc1 = 0x%x\n",val);
    
	val = 0x4;
	ret = fseek(file, RIGHT_DELAY_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("right_phase_inc1 = 0x%x\n",val);


	val = 0x8;
	ret = fseek(file, LEFT_DELAY_OFFSET2, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("left_phase_inc2 = 0x%x\n",val);
    
	val = 0x8;
	ret = fseek(file, RIGHT_DELAY_OFFSET2, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("right_phase_inc2 = 0x%x\n",val);

	val = 0x5000;
    	ret = fseek(file, LEFT_GAIN_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("left_gain = 0x%x\n", val);

	val = 0x5000;
   	 ret = fseek(file, RIGHT_GAIN_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("right_gain = 0x%x\n", val);


	val = 0x6000;
    	ret = fseek(file, LEFT_VOLUME_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("left_volume = 0x%x\n", val);

	val = 0x6000;
   	 ret = fseek(file, RIGHT_VOLUME_OFFSET, SEEK_SET);
	ret = fwrite(&val, 4, 1, file);
	printf("right_volume = 0x%x\n", val);
    
    
	

	printf("\n***************\n* register values after writing\n***************\n\n");
	
	// todo:  Read all the register back again and display the values and names of the associated control registers
	ret = fseek(file, 0, SEEK_SET);

	ret = fread(&val, 4, 1, file);
	printf("left_enable = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_phase_inc1 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_phase_inc2 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_gain = 0x%x\n", val);
    
//	ret = fread(&val, 4, 1, file);
//	printf("empty register = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("left_volume = 0x%x\n", val);

//	ret = fread(&val, 4, 1, file);
//	printf("empty register = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_enable = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_phase_inc1 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_phase_inc2 = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_gain = 0x%x\n", val);
    
//	ret = fread(&val, 4, 1, file);
//	printf("empty register = 0x%x\n", val);

	ret = fread(&val, 4, 1, file);
	printf("right_volume = 0x%x\n", val);

//	ret = fread(&val, 4, 1, file);
//	printf("empty register = 0x%x\n", val);  

	fclose(file);
	return 0;
}
