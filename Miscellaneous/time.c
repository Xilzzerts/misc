#include <sys/time.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#define START_LOG_TIME(num) struct timeval start##num, end##num;memset(&start##num, 0, sizeof(struct timeval));memset(&end##num, 0, sizeof(struct timeval));gettimeofday(&start##num, NULL);
#define END_LOG_TIME(num,TAG) gettimeofday(&end##num, NULL);printf(#TAG " %ld us\n", ((end##num.tv_sec - start##num.tv_sec) * 1000000 + end##num.tv_usec - start##num.tv_usec));

int main()
{
    START_LOG_TIME(1)
    sleep(1);
    END_LOG_TIME(1, TEST)
    return 0;
}
