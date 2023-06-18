#include <stdio.h>

int main(){

char num_str[500];
scanf("%s", num_str);

// implement state machine
int current_state = 0;
for(i=0;;i++) {
  switch (current_state) {
  case -1:
    current_state = -1;
    break;
  case 0:
    if (num_str[i] == '1') current_state = 1;
    else current_state = -1;
    break;
  case 1:
    if (num_str[i] == '2') current_state = 2;
    else current_state = -1;
    break;
  case 2:
    if (num_str[i] == '3') current_state = 3;
    else current_state = -1;
    break;
  case 3:
    if (num_str[i] == '4') current_state = 4;
    else current_state = -1;
    break;
  case 4:
    if (num_str[i] == '5') current_state = 5;
    else current_state = -1;
    break;
  case 5:
    if (num_str[i] == '6') current_state = 6;
    else current_state = -1;
    break;
  case 6:
    if (num_str[i] == '\0') current_state = 7;
    else current_state = -1;
    break;
  }
  if (num_str[i] == '\0') break;
}

if (!strcmp(num_str, "123456"))
  printf("Crash!!");

return 0;
}