#include<stdio.h>

int arrMax(int arr[5])
{
    int max = arr[0];
    int i = 0;
    while(i<5)
    {
        if(arr[i]>max)
        {
            max = arr[i];
        }
        i = i + 1;
    }

    return max;
}
int main()
{
    int arr[5] = {2,1,4,5,3};
    int max = arrMax(arr);
    printf("数组中最大值为:%d\n",max);

    return 0;
}