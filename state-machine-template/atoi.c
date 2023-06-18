int main() {
  char num_str[500];
  scanf("%s", num_str);

  // implement state machine
  // if (atoi(num_str) == 123456) printf("Crash!!");

  int state = 0;
  char *pc = num_str;
  while (1) {
    if (*pc == '\0') {
      if (state == 6 || state == 7) {
        printf("Crash!!");
      }
      break;
    }
    switch (state) {
      // state 0: Only whitespace characters are recognized
      case 0: {
        if ((*pc == '+') || (*pc == '0')) {
          state = -2;
        } else if (*pc == '1') {
          state = 1;
        } else if (!isspace(*pc)) {
          state = -1;
        }
        break;
      }
      // state -2: Plus sign is recognized
      case -2: {
        if (*pc == '1') {
          state = 1;
        } else if (*pc != '0') {
          state = -1;
        }
        break;
      }
      // state 1: The resulting number starts with "1"
      case 1: {
        if (*pc == '2') {
          state = 2;
        } else {
          state = -1;
        }
        break;
      }
      // state 2: The resulting number starts with "12"
      case 2: {
        if (*pc == '3') {
          state = 3;
        } else {
          state = -1;
        }
        break;
      }
      // state 3: The resulting number starts with "123"
      case 3: {
        if (*pc == '4') {
          state = 4;
        } else {
          state = -1;
        }
        break;
      }
      // state 4: The resulting number starts with "1234"
      case 4: {
        if (*pc == '5') {
          state = 5;
        } else {
          state = -1;
        }
        break;
      }
      // state 5: The resulting number starts with "12345"
      case 5: {
        if (*pc == '6') {
          state = 6;
        } else {
          state = -1;
        }
        break;
      }
      // state 6: The resulting number starts with "123456"
      case 6: {
        if (isdigit(*pc)) {
          state = -1;
        } else {
          state = 7;
        }
        break;
      }
      // state 7: The resulting number is "123456"
      // state -1: The resulting number is not "123456"
      default: {
      }
    }
    pc++;
  }

  return 0;
}