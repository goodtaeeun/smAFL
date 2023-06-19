int main()
{
    char num_str[500];
    scanf("%s", num_str);

    if (atoi(num_str) == 123456)
        printf("Crash!!");

    return 0;
}