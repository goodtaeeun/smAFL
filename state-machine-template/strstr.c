int main(){

char num_str[500];
scanf("%s", num_str);

// implement state machine

if (strstr(num_str, "1234"))
  printf("Crash!!");

return 0;
}