int main()
{

    char num_str[500];
    scanf("%s", num_str);

    // implement state machine
    int current_state = 0;
    for (int i = 0;; i++)
    {
        switch (current_state)
        {
        case 0:
            if (num_str[i] == '1')
                current_state = 1;
            else
                current_state = 0;
            break;
        case 1:
            if (num_str[i] == '2')
                current_state = 2;
            else
                current_state = 0;
            break;
        case 2:
            if (num_str[i] == '3')
                current_state = 3;
            else
                current_state = 0;
            break;
        case 3:
            if (num_str[i] == '4')
                current_state = 4;
            else
                current_state = 0;
            break;
        case 4:
            current_state = 4;
            break;
        }
        if (num_str[i] == '\0')
            break;
    }

    if (strstr(num_str, "1234"))
        printf("Crash!!");

    return 0;
}