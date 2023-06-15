int main(){

char num_str[500];
scanf("%s", num_str);

// implement state machine

if (!strcmp(num_str, "123456"))
  printf("Crash!!");

return 0;
}