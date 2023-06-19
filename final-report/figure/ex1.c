int main(int argc, char *argv[])
{
    if (argc < 2)
        return 1;

    if (!strcmp(argv[1], "HELLO"))
    {
        Crash();
        printf("Hello World!");
        return 0;
    }

    OK();
    return 0;
}